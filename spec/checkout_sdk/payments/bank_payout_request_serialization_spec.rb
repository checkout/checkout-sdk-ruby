# frozen_string_literal: true

require 'json'

RSpec.describe CheckoutSdk::Payments::PayoutRequest do
  def wire(object)
    JSON.parse(JSON.generate(CheckoutSdk::JsonSerializer.to_custom_hash(object)))
  end

  let(:address_json) do
    {
      'address_line1' => '123 High St.',
      'address_line2' => 'Flat 456',
      'city' => 'London',
      'zip' => 'SW1A 1AA',
      'country' => 'GB'
    }
  end

  # The schema has no request example; field examples from the schema are used where it declares them.
  let(:swagger_example) do
    {
      'source' => { 'type' => 'entity', 'id' => 'ent_w4jelhppmfiufdnatam37wrfc4' },
      'destination' => {
        'type' => 'bank_account',
        'account_type' => 'savings',
        'account_number' => '13654567455',
        'bank_code' => '123-456',
        'branch_code' => '6443',
        'iban' => 'HU93116000060000000012345676',
        'bban' => '3704 0044 0532 0130 00',
        'swift_bic' => '37040044',
        'country' => 'GB',
        'account_holder' => {
          'type' => 'individual',
          'first_name' => 'John',
          'last_name' => 'Smith',
          'tax_id' => '123456',
          'date_of_birth' => '1986-01-01',
          'country_of_birth' => 'GB',
          'residential_status' => 'resident',
          'billing_address' => address_json,
          'phone' => { 'country_code' => '+1', 'number' => '415 555 2671' }
        }
      },
      'amount' => 6540,
      'currency' => 'USD',
      'reference' => 'Withdrawal',
      'billing_descriptor' => { 'reference' => 'Withdrawal01' },
      'sender' => {
        'type' => 'individual',
        'reference' => 'CUST12345',
        'first_name' => 'John',
        'last_name' => 'Jones',
        'dob' => '1985-05-15',
        'address' => address_json
      },
      'instruction' => { 'scheme' => 'local', 'remittance' => { 'reference' => 'INV-2024-0001' } },
      'processing_channel_id' => 'pc_q4dbxom5jbgudnjzjpz7j2z6uq',
      'segment' => { 'brand' => 'Acme Corporation', 'business_category' => 'Inward Payments', 'market' => 'UK' }
    }
  end

  let(:address) do
    address = CheckoutSdk::Common::Address.new
    address.address_line1 = '123 High St.'
    address.address_line2 = 'Flat 456'
    address.city = 'London'
    address.zip = 'SW1A 1AA'
    address.country = CheckoutSdk::Common::Country::GB
    address
  end

  let(:account_holder) do
    phone = CheckoutSdk::Common::Phone.new
    phone.country_code = '+1'
    phone.number = '415 555 2671'

    holder = CheckoutSdk::Common::AccountHolder.new
    holder.type = CheckoutSdk::Common::AccountHolderType::INDIVIDUAL
    holder.first_name = 'John'
    holder.last_name = 'Smith'
    holder.tax_id = '123456'
    holder.date_of_birth = '1986-01-01'
    holder.country_of_birth = CheckoutSdk::Common::Country::GB
    holder.residential_status = 'resident'
    holder.billing_address = address
    holder.phone = phone
    holder
  end

  let(:destination) do
    destination = CheckoutSdk::Payments::BankAccountDestination.new
    destination.account_type = CheckoutSdk::Common::AccountType::SAVINGS
    destination.account_number = '13654567455'
    destination.bank_code = '123-456'
    destination.branch_code = '6443'
    destination.iban = 'HU93116000060000000012345676'
    destination.bban = '3704 0044 0532 0130 00'
    destination.swift_bic = '37040044'
    destination.country = CheckoutSdk::Common::Country::GB
    destination.account_holder = account_holder
    destination
  end

  let(:sender) do
    sender = CheckoutSdk::Payments::IndividualSender.new
    sender.reference = 'CUST12345'
    sender.first_name = 'John'
    sender.last_name = 'Jones'
    sender.dob = '1985-05-15'
    sender.address = address
    sender
  end

  let(:request) do
    source = CheckoutSdk::Payments::EntitySource.new
    source.id = 'ent_w4jelhppmfiufdnatam37wrfc4'

    billing_descriptor = CheckoutSdk::Payments::PayoutBillingDescriptor.new
    billing_descriptor.reference = 'Withdrawal01'

    remittance = CheckoutSdk::Payments::InstructionRemittance.new
    remittance.reference = 'INV-2024-0001'
    instruction = CheckoutSdk::Payments::PaymentInstruction.new
    instruction.scheme = CheckoutSdk::Payments::InstructionScheme::LOCAL
    instruction.remittance = remittance

    segment = CheckoutSdk::Payments::PaymentSegment.new
    segment.brand = 'Acme Corporation'
    segment.business_category = 'Inward Payments'
    segment.market = 'UK'

    request = described_class.new
    request.source = source
    request.destination = destination
    request.amount = 6540
    request.currency = CheckoutSdk::Common::Currency::USD
    request.reference = 'Withdrawal'
    request.billing_descriptor = billing_descriptor
    request.sender = sender
    request.instruction = instruction
    request.processing_channel_id = 'pc_q4dbxom5jbgudnjzjpz7j2z6uq'
    request.segment = segment
    request
  end

  it 'serializes exactly the ten snake case keys the bank payout schema declares' do
    expect(wire(request).keys.sort).to eq(%w[amount billing_descriptor currency destination instruction
                                             processing_channel_id reference segment sender source])
  end

  it 'serializes the whole body to the swagger example' do
    json = wire(request)

    expect(json).to eq(swagger_example)
    expect(json['amount']).to be_an(Integer)
  end

  it 'round trips every property through JSON' do
    json = wire(request)

    %i[amount currency reference processing_channel_id].each do |attr|
      expect(json[attr.to_s]).to eq(request.public_send(attr))
    end
    expect(json['source']).to eq('type' => request.source.type, 'id' => request.source.id)
    expect(json['billing_descriptor']).to eq('reference' => request.billing_descriptor.reference)
    %i[type account_type account_number bank_code branch_code iban bban swift_bic country].each do |attr|
      expect(json['destination'][attr.to_s]).to eq(destination.public_send(attr))
    end
    %i[type first_name last_name tax_id date_of_birth country_of_birth residential_status].each do |attr|
      expect(json['destination']['account_holder'][attr.to_s]).to eq(account_holder.public_send(attr))
    end
    %i[address_line1 address_line2 city zip country].each do |attr|
      expect(json['destination']['account_holder']['billing_address'][attr.to_s]).to eq(address.public_send(attr))
      expect(json['sender']['address'][attr.to_s]).to eq(address.public_send(attr))
    end
    %i[type reference first_name last_name dob].each do |attr|
      expect(json['sender'][attr.to_s]).to eq(sender.public_send(attr))
    end
    expect(json['instruction']).to eq('scheme' => request.instruction.scheme,
                                      'remittance' => { 'reference' => request.instruction.remittance.reference })
    %i[brand business_category market].each do |attr|
      expect(json['segment'][attr.to_s]).to eq(request.segment.public_send(attr))
    end
  end

  it 'nests an id destination without an account holder' do
    id_destination = CheckoutSdk::Payments::IdDestination.new
    id_destination.id = 'src_wmlfc3zyhqzehihu7giusaaawu'
    request.destination = id_destination

    expect(wire(request)['destination']).to eq('type' => 'id', 'id' => 'src_wmlfc3zyhqzehihu7giusaaawu')
  end

  it 'serializes an instrument sender with its reference only' do
    instrument_sender = CheckoutSdk::Payments::InstrumentSender.new
    instrument_sender.reference = 'CUST12345'
    request.sender = instrument_sender

    expect(wire(request)['sender']).to eq('type' => 'instrument', 'reference' => 'CUST12345')
  end
end
