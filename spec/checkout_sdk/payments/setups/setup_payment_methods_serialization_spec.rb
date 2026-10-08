# frozen_string_literal: true

RSpec.describe 'Payment Setups payment-method configs serialization' do
  describe CheckoutSdk::Payments::BacsPaymentMethod do
    it 'serializes its fields to their swagger keys' do
      pm = described_class.new
      pm.status = 'available'
      pm.flags = %w[flag_a]
      pm.instrument_id = 'src_wkq7552u245upl5h75x24554xy'
      pm.initialization = 'setup'
      pm.account_holder = { 'type' => 'individual', 'first_name' => 'John' }
      pm.account_number = '12345678'
      pm.bank_code = '200000'
      pm.country = 'GB'
      pm.currency = 'GBP'
      pm.allow_partial_match = true

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(pm)

      expect(hash['status']).to eq('available')
      expect(hash['flags']).to eq(%w[flag_a])
      expect(hash['instrument_id']).to eq('src_wkq7552u245upl5h75x24554xy')
      expect(hash['initialization']).to eq('setup')
      expect(hash['account_holder']).to eq({ 'type' => 'individual', 'first_name' => 'John' })
      expect(hash['account_number']).to eq('12345678')
      expect(hash['bank_code']).to eq('200000')
      expect(hash['country']).to eq('GB')
      expect(hash['currency']).to eq('GBP')
      expect(hash['allow_partial_match']).to be(true)
    end
  end

  describe CheckoutSdk::Payments::CardPresentPaymentMethod do
    it 'serializes its fields to their swagger keys' do
      pm = described_class.new
      pm.status = 'available'
      pm.flags = %w[flag_a]
      pm.track2 = 'track2-data'
      pm.emv = 'emv-data'
      pm.entry_mode = 'contactless'
      pm.pin = { 'key_set_id' => 'ks_1', 'block' => 'b', 'block_format' => 'iso0' }
      pm.store_for_future_use = true
      pm.name = 'John Smith'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(pm)

      expect(hash['status']).to eq('available')
      expect(hash['flags']).to eq(%w[flag_a])
      expect(hash['track2']).to eq('track2-data')
      expect(hash['emv']).to eq('emv-data')
      expect(hash['entry_mode']).to eq('contactless')
      expect(hash['pin']).to eq({ 'key_set_id' => 'ks_1', 'block' => 'b', 'block_format' => 'iso0' })
      expect(hash['store_for_future_use']).to be(true)
      expect(hash['name']).to eq('John Smith')
    end
  end

  describe CheckoutSdk::Payments::PayByBankPaymentMethod do
    it 'serializes bank_id, status, flags and action' do
      pm = described_class.new
      pm.bank_id = 'ob-natwest'
      pm.status = 'available'
      pm.flags = %w[flag_a]
      pm.action = { 'type' => 'select_bank', 'banks' => [{ 'bank_id' => 'ob-natwest' }] }

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(pm)

      expect(hash['bank_id']).to eq('ob-natwest')
      expect(hash['status']).to eq('available')
      expect(hash['flags']).to eq(%w[flag_a])
      expect(hash['action']).to eq({ 'type' => 'select_bank', 'banks' => [{ 'bank_id' => 'ob-natwest' }] })
    end
  end

  describe CheckoutSdk::Payments::StablecoinPaymentMethod do
    it 'serializes its response fields' do
      pm = described_class.new
      pm.status = 'available'
      pm.flags = %w[flag_a]

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(pm)

      expect(hash['status']).to eq('available')
      expect(hash['flags']).to eq(%w[flag_a])
    end
  end

  describe 'order amount_allocations (reuses Common::AmountAllocations)' do
    it 'serializes id, amount, reference and commission' do
      allocation = CheckoutSdk::Common::AmountAllocations.new
      allocation.id = 'ent_w4jelhppmfiufdnatam37wrfc4'
      allocation.amount = 1000
      allocation.reference = 'ORD-5023-4E89'
      allocation.commission = CheckoutSdk::Common::Commission.new

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(allocation)

      expect(hash['id']).to eq('ent_w4jelhppmfiufdnatam37wrfc4')
      expect(hash['amount']).to eq(1000)
      expect(hash['reference']).to eq('ORD-5023-4E89')
      expect(hash).to have_key('commission')
    end
  end

  describe CheckoutSdk::Payments::CashAppPaymentMethod do
    let(:redirect_url) do
      'https://sandbox.api.cash.app/customer-request/v1/requests/GRR_f5xg6wrxhtv3p4w24g0wrexa/interstitial?validity_token=bap03y'
    end

    let(:address) do
      {
        'address_line_1' => '123 Main St',
        'address_line_2' => 'Apt 2',
        'address_line_3' => 'Floor 3',
        'locality' => 'Springfield',
        'sublocality' => 'Downtown',
        'administrative_district_level_1' => 'IL',
        'postal_code' => '62701',
        'country' => 'US'
      }
    end

    let(:customer_profile) do
      {
        'customer_id' => 'CST_AYVkuLzfsRqEhf4OyQFxQNv22m7IjNFjO6f2J5CDE2nxAC4-21wJ2H8_2kvsdIsDZMN4',
        'cashtag' => '$CASHTAG_C_TOKEN',
        'reference_id' => 'value',
        'full_name' => 'John Middle Doe',
        'given_name' => 'John',
        'middle_name' => 'Middle',
        'family_name' => 'Doe',
        'suffix' => 'Jr.',
        'birth_date' => '1990-01-01T00:00:00.0000000',
        'address' => address,
        'phone_number' => '5555555555',
        'email_address' => 'cash@cash.com',
        'customer_since' => '1970-01-18T12:46:04.8000000+00:00'
      }
    end

    let(:api_client) do
      configuration = double('CheckoutConfiguration',
                             http_client: Faraday.new,
                             multipart_http_client: Faraday.new,
                             logger: Logger.new(nil))
      CheckoutSdk::ApiClient.new(configuration, 'https://api.sandbox.checkout.com')
    end

    def parse_json(body)
      response = double('Response', status: 200, body: body, headers: { 'Content-Type' => 'application/json' })
      api_client.send(:parse_response, response)
    end

    it 'serializes every field to its swagger key' do
      pm = described_class.new
      pm.status = 'action_required'
      pm.flags = []
      pm.initialization = 'enabled'
      pm.customer_profile_sharing = true
      pm.customer_profile = customer_profile
      pm.reference = 'ORDER-99'
      pm.action = { 'type' => CheckoutSdk::Payments::CashAppActionType::REDIRECT, 'redirect_url' => redirect_url }

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(pm)

      expect(hash.keys).to contain_exactly('status', 'flags', 'initialization', 'customer_profile_sharing',
                                           'customer_profile', 'reference', 'action')
      expect(hash['status']).to eq('action_required')
      expect(hash['flags']).to eq([])
      expect(hash['initialization']).to eq('enabled')
      expect(hash['customer_profile_sharing']).to be(true)
      expect(hash['customer_profile']).to eq(customer_profile)
      expect(hash['reference']).to eq('ORDER-99')
      expect(hash['action']).to eq({ 'type' => 'redirect', 'redirect_url' => redirect_url })
    end

    it 'is sent under the literal cashapp key with the merchant fields' do
      request = { payment_methods: { cashapp: { initialization: 'enabled', customer_profile_sharing: true } } }

      json = CheckoutSdk::JsonSerializer.to_custom_hash(request).to_json

      expect(json).to include('"payment_methods":{"cashapp":{')
      expect(json).not_to include('cash_app')
      expect(json).not_to include('cashApp')
      expect(json).not_to include('customerProfileSharing')
      sent = JSON.parse(json)['payment_methods']['cashapp']
      expect(sent).to eq({ 'initialization' => 'enabled', 'customer_profile_sharing' => true })
    end

    it 'serializes the typed object exactly like its Hash form' do
      pm = described_class.new
      pm.initialization = 'enabled'
      pm.customer_profile_sharing = true
      hash_form = { 'initialization' => 'enabled', 'customer_profile_sharing' => true }

      expect(CheckoutSdk::JsonSerializer.serialize_by_type(pm))
        .to eq(CheckoutSdk::JsonSerializer.serialize_by_type(hash_form))
    end

    it 'keeps customer_profile_sharing false on the wire' do
      pm = described_class.new
      pm.customer_profile_sharing = false

      json = CheckoutSdk::JsonSerializer.to_custom_hash(pm).to_json

      expect(json).to eq('{"customer_profile_sharing":false}')
    end

    it 'reads the swagger example response with dot access' do
      body = {
        'id' => 'ps_2Un4WvKHNwAdrXDqTWOvGOgICcr',
        'payment_methods' => {
          'cashapp' => {
            'status' => 'action_required',
            'flags' => [],
            'initialization' => 'enabled',
            'customer_profile_sharing' => true,
            'reference' => 'ORDER-99',
            'action' => { 'type' => 'redirect', 'redirect_url' => redirect_url },
            'customer_profile' => customer_profile
          }
        }
      }.to_json

      cashapp = parse_json(body).payment_methods.cashapp

      expect(cashapp.status).to eq('action_required')
      expect(cashapp.flags).to eq([])
      expect(cashapp.initialization).to eq('enabled')
      expect(cashapp.customer_profile_sharing).to be(true)
      expect(cashapp.reference).to eq('ORDER-99')
      expect(cashapp.action.type).to eq(CheckoutSdk::Payments::CashAppActionType::REDIRECT)
      expect(cashapp.action.redirect_url).to eq(redirect_url)
      profile = cashapp.customer_profile
      expect(profile.customer_id).to eq('CST_AYVkuLzfsRqEhf4OyQFxQNv22m7IjNFjO6f2J5CDE2nxAC4-21wJ2H8_2kvsdIsDZMN4')
      expect(profile.cashtag).to eq('$CASHTAG_C_TOKEN')
      expect(profile.reference_id).to eq('value')
      expect(profile.full_name).to eq('John Middle Doe')
      expect(profile.given_name).to eq('John')
      expect(profile.middle_name).to eq('Middle')
      expect(profile.family_name).to eq('Doe')
      expect(profile.suffix).to eq('Jr.')
      expect(profile.birth_date).to eq('1990-01-01T00:00:00.0000000')
      expect(profile.phone_number).to eq('5555555555')
      expect(profile.email_address).to eq('cash@cash.com')
      expect(profile.customer_since).to eq('1970-01-18T12:46:04.8000000+00:00')
      expect(profile.address.address_line_1).to eq('123 Main St')
      expect(profile.address.address_line_2).to eq('Apt 2')
      expect(profile.address.address_line_3).to eq('Floor 3')
      expect(profile.address.locality).to eq('Springfield')
      expect(profile.address.sublocality).to eq('Downtown')
      expect(profile.address.administrative_district_level_1).to eq('IL')
      expect(profile.address.postal_code).to eq('62701')
      expect(profile.address.country).to eq('US')
      expect(profile.to_h.keys.size).to eq(13)
      expect(profile.address.to_h.keys.size).to eq(8)
    end

    it 'round trips every field and keeps the Cash App address keys literally' do
      pm = described_class.new
      pm.status = 'ready'
      pm.flags = []
      pm.initialization = 'enabled'
      pm.customer_profile_sharing = true
      pm.customer_profile = customer_profile
      pm.reference = 'ORDER-99'
      pm.action = { 'type' => 'redirect', 'redirect_url' => redirect_url }

      json = CheckoutSdk::JsonSerializer.to_custom_hash(pm).to_json
      read = parse_json(json)

      expect(json).to include('"address_line_1":', '"address_line_2":', '"address_line_3":',
                              '"administrative_district_level_1":')
      expect(json).not_to include('address_line1')
      expect(json).not_to include('administrative_district_level1')
      expect(read.status).to eq('ready')
      expect(read.flags).to eq([])
      expect(read.initialization).to eq('enabled')
      expect(read.customer_profile_sharing).to be(true)
      expect(read.reference).to eq('ORDER-99')
      expect(read.action.type).to eq('redirect')
      expect(read.action.redirect_url).to eq(redirect_url)
      read_profile = read.customer_profile.to_h.transform_keys(&:to_s)
      read_profile['address'] = read_profile['address'].to_h.transform_keys(&:to_s)
      expect(read_profile).to eq(customer_profile)
    end
  end
end
