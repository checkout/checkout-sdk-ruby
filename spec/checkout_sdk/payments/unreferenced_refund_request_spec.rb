# frozen_string_literal: true

require 'json'
require 'open3'
require 'rbconfig'

RSpec.describe CheckoutSdk::Payments::UnreferencedRefundRequest do
  def wire(object)
    JSON.parse(JSON.generate(CheckoutSdk::JsonSerializer.to_custom_hash(object)))
  end

  let(:account_holder_json) do
    {
      'type' => 'individual',
      'first_name' => 'John',
      'middle_name' => 'Paul',
      'last_name' => 'Smith',
      'billing_address' => {
        'address_line1' => '123 High St.',
        'address_line2' => 'Flat 456',
        'city' => 'London',
        'state' => 'GB',
        'zip' => 'SW1A 1AA',
        'country' => 'GB'
      },
      'phone' => { 'country_code' => '+44', 'number' => '4155552671' },
      'identification' => {
        'type' => 'passport',
        'number' => 'E12345678',
        'issuing_country' => 'GB',
        'date_of_expiry' => '2030-01-01'
      },
      'email' => 'john.smith@example.com',
      'date_of_birth' => '1985-05-15',
      'country_of_birth' => 'GB'
    }
  end

  # The schema has no request example; field examples from the schema are used where it declares them.
  let(:swagger_example) do
    {
      'payment_type' => 'UnreferencedRefund',
      'source' => { 'type' => 'currency_account', 'id' => 'ca_y3oqhf46pyzuxjbcn2giaqnb44' },
      'destination' => {
        'type' => 'card',
        'number' => '4242424242424242',
        'expiry_month' => 6,
        'expiry_year' => 2030,
        'account_holder' => account_holder_json
      },
      'instruction' => { 'funds_transfer_type' => 'MI', 'purpose' => 'family_support' },
      'amount' => 1000,
      'currency' => 'GBP',
      'processing_channel_id' => 'pc_q4dbxom5jbgudnjzjpz7j2z6uq',
      'reference' => 'ORD-5023-4E89',
      'metadata' => { 'coupon_code' => 'NY2018', 'partner_id' => 123_989 },
      'previous_payment_id' => 'pay_fun26akvvjjerahhctaq2uzhu4',
      'segment' => { 'brand' => 'Acme Corporation', 'business_category' => 'Inward Payments', 'market' => 'UK' },
      'processing' => { 'processing_speed' => 'fast' }
    }
  end

  let(:account_holder) do
    address = CheckoutSdk::Common::Address.new
    address.address_line1 = '123 High St.'
    address.address_line2 = 'Flat 456'
    address.city = 'London'
    address.state = 'GB'
    address.zip = 'SW1A 1AA'
    address.country = CheckoutSdk::Common::Country::GB

    phone = CheckoutSdk::Common::Phone.new
    phone.country_code = '+44'
    phone.number = '4155552671'

    identification = CheckoutSdk::Common::AccountHolderIdentification.new
    identification.type = CheckoutSdk::Common::AccountHolderIdentificationType::PASSPORT
    identification.number = 'E12345678'
    identification.issuing_country = CheckoutSdk::Common::Country::GB
    identification.date_of_expiry = '2030-01-01'

    holder = CheckoutSdk::Common::AccountHolder.new
    holder.type = CheckoutSdk::Common::AccountHolderType::INDIVIDUAL
    holder.first_name = 'John'
    holder.middle_name = 'Paul'
    holder.last_name = 'Smith'
    holder.billing_address = address
    holder.phone = phone
    holder.identification = identification
    holder.email = 'john.smith@example.com'
    holder.date_of_birth = '1985-05-15'
    holder.country_of_birth = CheckoutSdk::Common::Country::GB
    holder
  end

  let(:card_destination) do
    destination = CheckoutSdk::Payments::CardDestination.new
    destination.number = '4242424242424242'
    destination.expiry_month = 6
    destination.expiry_year = 2030
    destination.account_holder = account_holder
    destination
  end

  let(:network_token_destination) do
    destination = CheckoutSdk::Payments::NetworkTokenDestination.new
    destination.token = '4543474002249996'
    destination.expiry_month = 6
    destination.expiry_year = 2025
    destination.token_type = CheckoutSdk::Payments::NetworkTokenType::VTS
    destination.cryptogram = 'hv8mUFzPzRZoCAAAAAEQBDMAAAA='
    destination.eci = '05'
    destination.account_holder = account_holder
    destination
  end

  let(:id_destination) do
    destination = CheckoutSdk::Payments::IdDestination.new
    destination.id = 'src_wmlfc3zyhqzehihu7giusaaawu'
    destination
  end

  let(:token_destination) do
    destination = CheckoutSdk::Payments::TokenDestination.new
    destination.token = 'tok_ubfj2q76miwundwlk72vxt2i7q'
    destination
  end

  let(:full_request) do
    source = CheckoutSdk::Payments::CurrencyAccountSource.new
    source.id = 'ca_y3oqhf46pyzuxjbcn2giaqnb44'

    instruction = CheckoutSdk::Payments::PaymentInstruction.new
    instruction.funds_transfer_type = 'MI'
    instruction.purpose = CheckoutSdk::Payments::PaymentPurposeType::FAMILY_SUPPORT

    segment = CheckoutSdk::Payments::PaymentSegment.new
    segment.brand = 'Acme Corporation'
    segment.business_category = 'Inward Payments'
    segment.market = 'UK'

    processing = CheckoutSdk::Payments::CardPayoutProcessing.new
    processing.processing_speed = 'fast'

    request = described_class.new
    request.source = source
    request.destination = card_destination
    request.instruction = instruction
    request.amount = 1000
    request.currency = CheckoutSdk::Common::Currency::GBP
    request.processing_channel_id = 'pc_q4dbxom5jbgudnjzjpz7j2z6uq'
    request.reference = 'ORD-5023-4E89'
    request.metadata = { 'coupon_code' => 'NY2018', 'partner_id' => 123_989 }
    request.previous_payment_id = 'pay_fun26akvvjjerahhctaq2uzhu4'
    request.segment = segment
    request.processing = processing
    request
  end

  it 'sets payment_type to the UnreferencedRefund literal in the constructor' do
    expect(described_class.new.payment_type).to eq('UnreferencedRefund')
    expect(wire(described_class.new)).to eq('payment_type' => 'UnreferencedRefund')
  end

  it 'serializes exactly the twelve snake case keys the schema declares' do
    json = wire(full_request)

    expect(json.keys.sort).to eq(%w[amount currency destination instruction metadata payment_type previous_payment_id
                                    processing processing_channel_id reference segment source])
  end

  it 'serializes to the swagger example' do
    expect(wire(full_request)).to eq(swagger_example)
  end

  it 'nests the card destination under destination' do
    destination = wire(full_request)['destination']

    expect(destination.keys.sort).to eq(%w[account_holder expiry_month expiry_year number type])
    expect(destination['type']).to eq('card')
    expect(destination['expiry_month']).to be_an(Integer)
    expect(destination['expiry_year']).to be_an(Integer)
  end

  it 'nests the network token destination under destination' do
    full_request.destination = network_token_destination

    destination = wire(full_request)['destination']

    expect(destination).to eq(
      'type' => 'network_token',
      'token' => '4543474002249996',
      'expiry_month' => 6,
      'expiry_year' => 2025,
      'token_type' => 'vts',
      'cryptogram' => 'hv8mUFzPzRZoCAAAAAEQBDMAAAA=',
      'eci' => '05',
      'account_holder' => account_holder_json
    )
  end

  it 'nests the id destination under destination and omits the optional account holder when unset' do
    full_request.destination = id_destination

    expect(wire(full_request)['destination']).to eq('type' => 'id', 'id' => 'src_wmlfc3zyhqzehihu7giusaaawu')
  end

  it 'nests the token destination under destination and omits the optional account holder when unset' do
    full_request.destination = token_destination

    expect(wire(full_request)['destination']).to eq('type' => 'token', 'token' => 'tok_ubfj2q76miwundwlk72vxt2i7q')
  end

  it 'serializes the optional rich account holder on the id and token destinations when set' do
    [id_destination, token_destination].each do |destination|
      destination.account_holder = account_holder
      full_request.destination = destination

      expect(wire(full_request)['destination']['account_holder']).to eq(account_holder_json)
    end
  end

  it 'omits every optional property when only the required ones are set' do
    request = described_class.new
    request.source = full_request.source
    request.destination = token_destination
    request.amount = 1000
    request.currency = CheckoutSdk::Common::Currency::GBP
    request.processing_channel_id = 'pc_q4dbxom5jbgudnjzjpz7j2z6uq'

    expect(wire(request).keys.sort).to eq(%w[amount currency destination payment_type processing_channel_id source])
  end

  it 'round trips every property through JSON' do
    json = wire(full_request)

    %i[amount currency payment_type processing_channel_id reference metadata previous_payment_id].each do |attr|
      expect(json[attr.to_s]).to eq(full_request.public_send(attr))
    end
    expect(json['source']).to eq('type' => full_request.source.type, 'id' => full_request.source.id)
    expect(json['instruction']).to eq('funds_transfer_type' => full_request.instruction.funds_transfer_type,
                                      'purpose' => full_request.instruction.purpose)
    %i[brand business_category market].each do |attr|
      expect(json['segment'][attr.to_s]).to eq(full_request.segment.public_send(attr))
    end
    expect(json['processing']['processing_speed']).to eq(full_request.processing.processing_speed)
    %i[type number expiry_month expiry_year].each do |attr|
      expect(json['destination'][attr.to_s]).to eq(full_request.destination.public_send(attr))
    end
  end

  it 'loads through require checkout_sdk alone' do
    lib = File.expand_path('../../../lib', __dir__)
    script = "require 'checkout_sdk'; print CheckoutSdk::Payments::UnreferencedRefundRequest.new.payment_type"

    output, status = Open3.capture2(RbConfig.ruby, '-I', lib, '-e', script)

    expect(status).to be_success
    expect(output).to eq('UnreferencedRefund')
  end
end

RSpec.describe CheckoutSdk::Payments::PaymentsClient do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { described_class.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#request_unreferenced_refund' do
    it 'POSTs the typed request to payments' do
      request = CheckoutSdk::Payments::UnreferencedRefundRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments', 'secret_key', request, nil).and_return('r')
      expect(client.request_unreferenced_refund(request)).to eq('r')
    end

    it 'passes through an idempotency key' do
      request = CheckoutSdk::Payments::UnreferencedRefundRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments', 'secret_key', request, 'idem-1').and_return('r')
      expect(client.request_unreferenced_refund(request, 'idem-1')).to eq('r')
    end

    it 'also accepts a raw Hash' do
      hash = { 'payment_type' => 'UnreferencedRefund' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments', 'secret_key', hash, nil).and_return('r')
      expect(client.request_unreferenced_refund(hash)).to eq('r')
    end
  end
end
