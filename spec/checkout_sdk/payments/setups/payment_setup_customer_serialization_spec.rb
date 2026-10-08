# frozen_string_literal: true

RSpec.describe 'Payment Setups customer and device serialization' do
  let(:device) do
    {
      locale: 'en_US',
      fingerprint: 'fp_abc123xyz',
      ipv4: '203.0.113.0',
      ipv6: '2001:db8:85a3::8a2e:370:7334',
      client: CheckoutSdk::Payments::PaymentSetupDeviceClient::WEB,
      os: CheckoutSdk::Payments::PaymentSetupDeviceOs::ANDROID
    }
  end

  let(:customer) do
    {
      country: 'GB',
      id: 'cus_123456789',
      email: { address: 'johnsmith@example.com', verified: true },
      name: 'John Smith',
      tax_number: 'GB123456789',
      phone: { country_code: '+44', number: '207 946 0000' },
      device: device,
      merchant_account: {
        id: '1234',
        registration_date: '2023-05-01T00:00:00.0000000',
        last_modified: '2023-05-01T00:00:00.0000000',
        returning_customer: true,
        first_transaction_date: '2023-09-15T00:00:00.0000000',
        last_transaction_date: '2025-03-28T00:00:00.0000000',
        total_order_count: 6,
        last_payment_amount: 55.99
      }
    }
  end

  let(:api_client) do
    configuration = double('CheckoutConfiguration',
                           http_client: Faraday.new,
                           multipart_http_client: Faraday.new,
                           logger: Logger.new(nil))
    CheckoutSdk::ApiClient.new(configuration, 'https://api.sandbox.checkout.com')
  end

  def wire(request)
    JSON.parse(CheckoutSdk::JsonSerializer.to_custom_hash(request).to_json)
  end

  def parse_json(body)
    response = double('Response', status: 200, body: body, headers: { 'Content-Type' => 'application/json' })
    api_client.send(:parse_response, response)
  end

  describe CheckoutSdk::Payments::PaymentSetupDeviceClient do
    it 'serializes web' do
      expect(wire({ client: described_class::WEB })).to eq({ 'client' => 'web' })
    end

    it 'serializes mobile_web' do
      expect(wire({ client: described_class::MOBILE_WEB })).to eq({ 'client' => 'mobile_web' })
    end

    it 'serializes app' do
      expect(wire({ client: described_class::APP })).to eq({ 'client' => 'app' })
    end
  end

  describe CheckoutSdk::Payments::PaymentSetupDeviceOs do
    it 'serializes android' do
      expect(wire({ os: described_class::ANDROID })).to eq({ 'os' => 'android' })
    end

    it 'serializes ios' do
      expect(wire({ os: described_class::IOS })).to eq({ 'os' => 'ios' })
    end
  end

  describe 'customer.device' do
    it 'serializes exactly the six device keys with their values' do
      expect(wire({ customer: { device: device } })['customer']['device']).to eq(
        'locale' => 'en_US',
        'fingerprint' => 'fp_abc123xyz',
        'ipv4' => '203.0.113.0',
        'ipv6' => '2001:db8:85a3::8a2e:370:7334',
        'client' => 'web',
        'os' => 'android'
      )
    end

    it 'serializes only locale when only locale is set' do
      expect(wire({ customer: { device: { locale: 'en_US' } } })['customer']['device']).to eq('locale' => 'en_US')
    end
  end

  describe 'customer' do
    it 'serializes id, country and tax_number with their literal keys' do
      json = CheckoutSdk::JsonSerializer.to_custom_hash({ customer: customer }).to_json
      sent = JSON.parse(json)['customer']

      expect(sent.keys).to contain_exactly('country', 'id', 'email', 'name', 'tax_number', 'phone', 'device',
                                           'merchant_account')
      expect(sent['id']).to eq('cus_123456789')
      expect(sent['country']).to eq('GB')
      expect(sent['tax_number']).to eq('GB123456789')
      expect(json).not_to include('taxNumber')
    end

    it 'round trips all eight customer properties with nested objects populated' do
      json = CheckoutSdk::JsonSerializer.to_custom_hash({ customer: customer }).to_json
      read = parse_json(json).customer

      expect(read.country).to eq('GB')
      expect(read.id).to eq('cus_123456789')
      expect(read.email.address).to eq('johnsmith@example.com')
      expect(read.email.verified).to be(true)
      expect(read.name).to eq('John Smith')
      expect(read.tax_number).to eq('GB123456789')
      expect(read.phone.country_code).to eq('+44')
      expect(read.phone.number).to eq('207 946 0000')
      expect(read.device.to_h).to eq(device)
      expect(read.merchant_account.to_h).to eq(customer[:merchant_account])
    end

    it 'reads the swagger example customer, including the device fields' do
      body = {
        'id' => 'ps_2Un4WvKHNwAdrXDqTWOvGOgICcr',
        'customer' => {
          'country' => 'GB',
          'id' => 'cus_123456789',
          'email' => { 'address' => 'johnsmith@example.com', 'verified' => true },
          'name' => 'John Smith',
          'tax_number' => 'GB123456789',
          'phone' => { 'country_code' => '+44', 'number' => '207 946 0000' },
          'device' => {
            'locale' => 'en_GB',
            'fingerprint' => 'fp_abc123xyz',
            'ipv4' => '203.0.113.0',
            'ipv6' => '2001:db8:85a3::8a2e:370:7334',
            'client' => 'web',
            'os' => 'android'
          },
          'merchant_account' => {
            'id' => '1234',
            'registration_date' => '2023-05-01',
            'last_modified' => '2023-05-01',
            'returning_customer' => true,
            'first_transaction_date' => '2023-09-15',
            'last_transaction_date' => '2025-03-28',
            'total_order_count' => 6,
            'last_payment_amount' => 55.99
          }
        }
      }.to_json

      read = parse_json(body).customer

      expect(read.id).to eq('cus_123456789')
      expect(read.country).to eq('GB')
      expect(read.tax_number).to eq('GB123456789')
      expect(read.name).to eq('John Smith')
      expect(read.email.address).to eq('johnsmith@example.com')
      expect(read.email.verified).to be(true)
      expect(read.phone.country_code).to eq('+44')
      expect(read.phone.number).to eq('207 946 0000')
      expect(read.device.locale).to eq('en_GB')
      expect(read.device.fingerprint).to eq('fp_abc123xyz')
      expect(read.device.ipv4).to eq('203.0.113.0')
      expect(read.device.ipv6).to eq('2001:db8:85a3::8a2e:370:7334')
      expect(read.device.client).to eq(CheckoutSdk::Payments::PaymentSetupDeviceClient::WEB)
      expect(read.device.os).to eq(CheckoutSdk::Payments::PaymentSetupDeviceOs::ANDROID)
      expect(read.merchant_account.id).to eq('1234')
      expect(read.merchant_account.registration_date).to eq('2023-05-01')
      expect(read.merchant_account.last_modified).to eq('2023-05-01')
      expect(read.merchant_account.returning_customer).to be(true)
      expect(read.merchant_account.first_transaction_date).to eq('2023-09-15')
      expect(read.merchant_account.last_transaction_date).to eq('2025-03-28')
      expect(read.merchant_account.total_order_count).to eq(6)
      expect(read.merchant_account.last_payment_amount).to eq(55.99)
    end

    it 'exposes the payment method status and initialization values of the spec' do
      expect(CheckoutSdk::Payments::PaymentSetupPaymentMethodStatus.constants.map do |c|
        CheckoutSdk::Payments::PaymentSetupPaymentMethodStatus.const_get(c)
      end).to contain_exactly('unavailable', 'action_required', 'ready', 'initialization_required', 'invalid')
      expect(CheckoutSdk::Payments::PaymentSetupPaymentMethodInitialization.constants.map do |c|
        CheckoutSdk::Payments::PaymentSetupPaymentMethodInitialization.const_get(c)
      end).to contain_exactly('disabled', 'enabled')
    end
  end
end
