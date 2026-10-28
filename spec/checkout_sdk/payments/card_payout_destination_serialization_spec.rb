# frozen_string_literal: true

require 'json'
require 'open3'
require 'rbconfig'

RSpec.describe CheckoutSdk::Payments::NetworkTokenDestination do
  # Built from the swagger examples of the network token card payout destination.
  let(:swagger_example) do
    {
      'type' => 'network_token',
      'token' => '4543474002249996',
      'expiry_month' => 6,
      'expiry_year' => 2025,
      'token_type' => 'vts',
      'cryptogram' => 'hv8mUFzPzRZoCAAAAAEQBDMAAAA=',
      'eci' => '05',
      'account_holder' => {
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

  let(:minimal_destination) do
    destination = described_class.new
    destination.token = '4543474002249996'
    destination.expiry_month = 6
    destination.expiry_year = 2025
    destination.token_type = CheckoutSdk::Payments::NetworkTokenType::VTS
    destination.account_holder = account_holder
    destination
  end

  let(:full_destination) do
    destination = minimal_destination
    destination.cryptogram = 'hv8mUFzPzRZoCAAAAAEQBDMAAAA='
    destination.eci = '05'
    destination
  end

  def wire(object)
    JSON.parse(JSON.generate(CheckoutSdk::JsonSerializer.to_custom_hash(object)))
  end

  it 'serializes exactly the eight snake case keys the schema declares' do
    json = wire(full_destination)

    expect(json.keys.sort).to eq(%w[account_holder cryptogram eci expiry_month expiry_year token token_type type])
    expect(json['type']).to eq('network_token')
    expect(json.keys).to all(match(/\A[a-z_]+\z/))
  end

  it 'serializes to the swagger example, with integers kept as integers' do
    json = wire(full_destination)

    expect(json).to eq(swagger_example)
    expect(json['expiry_month']).to be_an(Integer)
    expect(json['expiry_year']).to be_an(Integer)
  end

  it 'omits cryptogram and eci when they are not set' do
    json = wire(minimal_destination)

    expect(json.keys.sort).to eq(%w[account_holder expiry_month expiry_year token token_type type])
  end

  it 'serializes every NetworkTokenType value to its literal' do
    values = CheckoutSdk::Payments::NetworkTokenType.constants.map do |c|
      CheckoutSdk::Payments::NetworkTokenType.const_get(c)
    end
    expect(values).to contain_exactly('vts', 'mdes', 'applepay', 'googlepay')

    values.each do |value|
      minimal_destination.token_type = value
      expect(wire(minimal_destination)['token_type']).to eq(value)
    end
  end

  it 'sets the type from DestinationType::NETWORK_TOKEN' do
    expect(CheckoutSdk::Payments::DestinationType::NETWORK_TOKEN).to eq('network_token')
    expect(described_class.new.type).to eq(CheckoutSdk::Payments::DestinationType::NETWORK_TOKEN)
  end

  it 'serializes under destination in a payout request with the rich account holder keys' do
    request = CheckoutSdk::Payments::PayoutRequest.new
    request.destination = full_destination

    destination = wire(request)['destination']

    expect(destination['type']).to eq('network_token')
    expect(destination['account_holder'].keys.sort)
      .to eq(%w[billing_address country_of_birth date_of_birth email first_name identification last_name
                middle_name phone type])
  end

  it 'round trips every property through JSON' do
    json = wire(full_destination)

    expect(json['type']).to eq(full_destination.type)
    expect(json['token']).to eq(full_destination.token)
    expect(json['expiry_month']).to eq(full_destination.expiry_month)
    expect(json['expiry_year']).to eq(full_destination.expiry_year)
    expect(json['token_type']).to eq(full_destination.token_type)
    expect(json['cryptogram']).to eq(full_destination.cryptogram)
    expect(json['eci']).to eq(full_destination.eci)
  end

  it 'round trips every account holder property through JSON' do
    holder = full_destination.account_holder
    json = wire(full_destination)['account_holder']

    %i[type first_name middle_name last_name email date_of_birth country_of_birth].each do |attr|
      expect(json[attr.to_s]).to eq(holder.public_send(attr))
    end
    {
      'billing_address' => %i[address_line1 address_line2 city state zip country],
      'phone' => %i[country_code number],
      'identification' => %i[type number issuing_country date_of_expiry]
    }.each do |key, attrs|
      nested = holder.public_send(key)
      expect(json[key]).to eq(attrs.to_h { |attr| [attr.to_s, nested.public_send(attr)] })
    end
  end

  it 'loads through require checkout_sdk alone' do
    lib = File.expand_path('../../../lib', __dir__)
    script = "require 'checkout_sdk'; print CheckoutSdk::Payments::NetworkTokenDestination.new.type"

    output, status = Open3.capture2(RbConfig.ruby, '-I', lib, '-e', script)

    expect(status).to be_success
    expect(output).to eq('network_token')
  end
end
