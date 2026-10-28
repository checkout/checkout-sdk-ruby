# frozen_string_literal: true

require 'json'

RSpec.describe CheckoutSdk::Payments::PayoutRequest do
  def wire(object)
    JSON.parse(JSON.generate(CheckoutSdk::JsonSerializer.to_custom_hash(object)))
  end

  let(:item) do
    item = CheckoutSdk::Payments::CardPayoutItem.new
    item.type = CheckoutSdk::Payments::ProductItemType::DIGITAL
    item.sub_type = CheckoutSdk::Payments::ProductSubType::STABLECOIN
    item
  end

  let(:processing) do
    processing = CheckoutSdk::Payments::CardPayoutProcessing.new
    processing.affiliate_id = 'AFF123'
    processing.affiliate_url = 'www.mycrypto.com'
    processing.processing_speed = 'fast'
    processing.purchase_country = CheckoutSdk::Common::Country::GB
    processing
  end

  let(:segment) do
    segment = CheckoutSdk::Payments::PaymentSegment.new
    segment.brand = 'Acme Corporation'
    segment.business_category = 'Inward Payments'
    segment.market = 'UK'
    segment
  end

  it 'serializes the card payout items, segment, previous_payment_id and processing keys' do
    request = described_class.new
    request.items = [item]
    request.segment = segment
    request.previous_payment_id = 'pay_fun26akvvjjerahhctaq2uzhu4'
    request.processing = processing

    expect(wire(request)).to eq(
      'items' => [{ 'type' => 'digital', 'sub_type' => 'stablecoin' }],
      'segment' => { 'brand' => 'Acme Corporation', 'business_category' => 'Inward Payments', 'market' => 'UK' },
      'previous_payment_id' => 'pay_fun26akvvjjerahhctaq2uzhu4',
      'processing' => {
        'affiliate_id' => 'AFF123',
        'affiliate_url' => 'www.mycrypto.com',
        'processing_speed' => 'fast',
        'purchase_country' => 'GB'
      }
    )
  end

  it 'round trips every new property through JSON' do
    request = described_class.new
    request.items = [item]
    request.segment = segment
    request.previous_payment_id = 'pay_fun26akvvjjerahhctaq2uzhu4'
    request.processing = processing

    json = wire(request)

    expect(json['items'].first).to eq('type' => item.type, 'sub_type' => item.sub_type)
    %i[brand business_category market].each do |attr|
      expect(json['segment'][attr.to_s]).to eq(segment.public_send(attr))
    end
    expect(json['previous_payment_id']).to eq(request.previous_payment_id)
    %i[affiliate_id affiliate_url processing_speed purchase_country].each do |attr|
      expect(json['processing'][attr.to_s]).to eq(processing.public_send(attr))
    end
  end

  it 'omits the new properties when they are not set' do
    expect(wire(described_class.new)).to eq({})
  end

  describe 'a full card payout' do
    # The schema has no request example; field examples from the schema are used where it declares them.
    let(:swagger_example) do
      {
        'source' => { 'type' => 'currency_account', 'id' => 'ca_y3oqhf46pyzuxjbcn2giaqnb44' },
        'destination' => {
          'type' => 'card',
          'number' => '4242424242424242',
          'expiry_month' => 6,
          'expiry_year' => 2030,
          'account_holder' => { 'type' => 'individual', 'first_name' => 'John', 'last_name' => 'Smith' }
        },
        'amount' => 1000,
        'currency' => 'GBP',
        'instruction' => { 'purpose' => 'family_support', 'funds_transfer_type' => 'AA' },
        'items' => [{ 'type' => 'digital', 'sub_type' => 'stablecoin' }],
        'processing_channel_id' => 'pc_q4dbxom5jbgudnjzjpz7j2z6uq',
        'sender' => {
          'type' => 'individual',
          'first_name' => 'John',
          'last_name' => 'Jones',
          'address' => { 'address_line1' => '123 High St.', 'city' => 'London', 'country' => 'GB' },
          'reference' => 'CUST12345',
          'reference_type' => 'other',
          'source_of_funds' => 'debit'
        },
        'reference' => 'ORD-5023-4E89',
        'previous_payment_id' => 'pay_fun26akvvjjerahhctaq2uzhu4',
        'metadata' => { 'udf1' => 'payout-1' },
        'segment' => { 'brand' => 'Acme Corporation', 'business_category' => 'Inward Payments', 'market' => 'UK' },
        'processing' => {
          'affiliate_id' => 'AFF123',
          'affiliate_url' => 'www.mycrypto.com',
          'processing_speed' => 'fast',
          'purchase_country' => 'GB'
        }
      }
    end

    let(:individual_holder) do
      holder = CheckoutSdk::Common::AccountHolder.new
      holder.type = CheckoutSdk::Common::AccountHolderType::INDIVIDUAL
      holder.first_name = 'John'
      holder.last_name = 'Smith'
      holder
    end

    let(:card_destination) do
      destination = CheckoutSdk::Payments::CardDestination.new
      destination.number = '4242424242424242'
      destination.expiry_month = 6
      destination.expiry_year = 2030
      destination.account_holder = individual_holder
      destination
    end

    let(:sender) do
      address = CheckoutSdk::Common::Address.new
      address.address_line1 = '123 High St.'
      address.city = 'London'
      address.country = CheckoutSdk::Common::Country::GB

      sender = CheckoutSdk::Payments::IndividualSender.new
      sender.first_name = 'John'
      sender.last_name = 'Jones'
      sender.address = address
      sender.reference = 'CUST12345'
      sender.reference_type = 'other'
      sender.source_of_funds = CheckoutSdk::Payments::SourceOfFunds::DEBIT
      sender
    end

    let(:request) do
      source = CheckoutSdk::Payments::CurrencyAccountSource.new
      source.id = 'ca_y3oqhf46pyzuxjbcn2giaqnb44'

      instruction = CheckoutSdk::Payments::PaymentInstruction.new
      instruction.purpose = CheckoutSdk::Payments::PaymentPurposeType::FAMILY_SUPPORT
      instruction.funds_transfer_type = 'AA'

      request = described_class.new
      request.source = source
      request.destination = card_destination
      request.amount = 1000
      request.currency = CheckoutSdk::Common::Currency::GBP
      request.instruction = instruction
      request.items = [item]
      request.processing_channel_id = 'pc_q4dbxom5jbgudnjzjpz7j2z6uq'
      request.sender = sender
      request.reference = 'ORD-5023-4E89'
      request.previous_payment_id = 'pay_fun26akvvjjerahhctaq2uzhu4'
      request.metadata = { 'udf1' => 'payout-1' }
      request.segment = segment
      request.processing = processing
      request
    end

    it 'serializes exactly the thirteen snake case keys the card payout schema declares' do
      expect(wire(request).keys.sort).to eq(%w[amount currency destination instruction items metadata
                                               previous_payment_id processing processing_channel_id reference
                                               segment sender source])
    end

    it 'serializes the whole body to the swagger example' do
      json = wire(request)

      expect(json).to eq(swagger_example)
      expect(json['amount']).to be_an(Integer)
      expect(json['destination']['expiry_month']).to be_an(Integer)
    end

    it 'round trips every property through JSON' do
      json = wire(request)

      %i[amount currency processing_channel_id reference previous_payment_id metadata].each do |attr|
        expect(json[attr.to_s]).to eq(request.public_send(attr))
      end
      expect(json['source']).to eq('type' => request.source.type, 'id' => request.source.id)
      %i[type number expiry_month expiry_year].each do |attr|
        expect(json['destination'][attr.to_s]).to eq(card_destination.public_send(attr))
      end
      %i[purpose funds_transfer_type].each do |attr|
        expect(json['instruction'][attr.to_s]).to eq(request.instruction.public_send(attr))
      end
      %i[type first_name last_name reference reference_type source_of_funds].each do |attr|
        expect(json['sender'][attr.to_s]).to eq(sender.public_send(attr))
      end
      %i[address_line1 city country].each do |attr|
        expect(json['sender']['address'][attr.to_s]).to eq(sender.address.public_send(attr))
      end
      expect(json['items']).to eq([{ 'type' => item.type, 'sub_type' => item.sub_type }])
      %i[brand business_category market].each do |attr|
        expect(json['segment'][attr.to_s]).to eq(segment.public_send(attr))
      end
      %i[affiliate_id affiliate_url processing_speed purchase_country].each do |attr|
        expect(json['processing'][attr.to_s]).to eq(processing.public_send(attr))
      end
    end

    it 'nests an id destination with a name only account holder' do
      destination = CheckoutSdk::Payments::IdDestination.new
      destination.id = 'src_wmlfc3zyhqzehihu7giusaaawu'
      destination.account_holder = individual_holder
      request.destination = destination

      expect(wire(request)['destination']).to eq(
        'type' => 'id',
        'id' => 'src_wmlfc3zyhqzehihu7giusaaawu',
        'account_holder' => { 'type' => 'individual', 'first_name' => 'John', 'last_name' => 'Smith' }
      )
    end

    it 'nests a token destination with a corporate account holder' do
      holder = CheckoutSdk::Common::AccountHolder.new
      holder.type = CheckoutSdk::Common::AccountHolderType::CORPORATE
      holder.company_name = 'Acme Corporation'
      destination = CheckoutSdk::Payments::TokenDestination.new
      destination.token = 'tok_ubfj2q76miwundwlk72vxt2i7q'
      destination.account_holder = holder
      request.destination = destination

      expect(wire(request)['destination']).to eq(
        'type' => 'token',
        'token' => 'tok_ubfj2q76miwundwlk72vxt2i7q',
        'account_holder' => { 'type' => 'corporate', 'company_name' => 'Acme Corporation' }
      )
    end

    it 'nests a card destination with its four required keys' do
      expect(wire(request)['destination'].keys.sort).to eq(%w[account_holder expiry_month expiry_year number type])
    end
  end
end
