# frozen_string_literal: true

RSpec.describe 'Payment Setups payment_type and account funding transaction serialization' do
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

  def constant_values(mod)
    mod.constants.map { |c| mod.const_get(c) }
  end

  describe CheckoutSdk::Payments::PaymentSetupPaymentType do
    it 'holds exactly the six lowercase values of the spec' do
      expect(constant_values(described_class))
        .to contain_exactly('regular', 'recurring', 'moto', 'installment', 'pay_later', 'unscheduled')
    end

    {
      REGULAR: 'regular',
      RECURRING: 'recurring',
      MOTO: 'moto',
      INSTALLMENT: 'installment',
      PAY_LATER: 'pay_later',
      UNSCHEDULED: 'unscheduled'
    }.each do |constant, value|
      it "sends #{constant} as \"#{value}\" under the payment_type key" do
        request = { amount: 1000, currency: 'GBP', payment_type: described_class.const_get(constant) }

        expect(wire(request)).to eq({ 'amount' => 1000, 'currency' => 'GBP', 'payment_type' => value })
      end
    end

    it 'is passed unchanged to the API on create and update' do
      api_client_mock = double('api_client')
      configuration_mock = double('configuration', credentials: double('credentials', get_authorization: 'sk'))
      client = CheckoutSdk::Payments::PaymentSetupsClient.new(api_client_mock, configuration_mock)
      request = { payment_type: described_class::PAY_LATER }

      expect(api_client_mock).to receive(:invoke_post).with('payments/setups', 'sk', request)
      expect(api_client_mock).to receive(:invoke_put).with('payments/setups/ps_1', 'sk', request)

      client.create_payment_setup(request)
      client.update_payment_setup('ps_1', request)
      expect(wire(request)).to eq({ 'payment_type' => 'pay_later' })
    end

    it 'reads payment_type from the swagger example response' do
      response = parse_json('{"id":"ps_2Un4WvKHNwAdrXDqTWOvGOgICcr","payment_type":"regular"}')

      expect(response.payment_type).to eq(described_class::REGULAR)
    end
  end

  describe CheckoutSdk::Payments::AccountFundingTransactionIdentificationType do
    it 'holds exactly the three values of the spec' do
      expect(constant_values(described_class)).to contain_exactly('passport', 'driving_license', 'national_id')
    end

    it 'no longer defines TAX_ID and OTHER, which the API rejects' do
      expect(described_class.const_defined?(:TAX_ID)).to be(false)
      expect(described_class.const_defined?(:OTHER)).to be(false)
    end
  end

  describe CheckoutSdk::Payments::AccountFundingTransactionIdentification do
    def identification
      identification = described_class.new
      identification.type = CheckoutSdk::Payments::AccountFundingTransactionIdentificationType::PASSPORT
      identification.number = '1234567890'
      identification.issuing_country = CheckoutSdk::Common::Country::US
      identification
    end

    it 'serializes every field to its swagger key' do
      expect(wire(identification)).to eq({ 'type' => 'passport', 'number' => '1234567890', 'issuing_country' => 'US' })
    end

    it 'sends each identification type under sender.identification.type' do
      %w[PASSPORT DRIVING_LICENSE NATIONAL_ID].each do |constant|
        value = CheckoutSdk::Payments::AccountFundingTransactionIdentificationType.const_get(constant)
        request = { account_funding_transaction: { sender: { identification: { type: value } } } }

        expect(wire(request).dig('account_funding_transaction', 'sender', 'identification', 'type')).to eq(value)
      end
    end

    it 'round trips every field through the API client' do
      response = parse_json(CheckoutSdk::JsonSerializer.to_custom_hash(identification).to_json)

      expect(response.type).to eq('passport')
      expect(response.number).to eq('1234567890')
      expect(response.issuing_country).to eq('US')
    end

    it 'reads the swagger example values' do
      body = '{"account_funding_transaction":{"sender":{"identification":' \
             '{"type":"driving_license","number":"1234567890","issuing_country":"US"}}}}'

      read = parse_json(body).account_funding_transaction.sender.identification

      expect(read.type).to eq(CheckoutSdk::Payments::AccountFundingTransactionIdentificationType::DRIVING_LICENSE)
      expect(read.number).to eq('1234567890')
      expect(read.issuing_country).to eq('US')
    end
  end

  describe CheckoutSdk::Payments::AccountFundingTransactionSender do
    def sender
      sender = described_class.new
      sender.reference = '0fc88634-78c1-4286-9cb6-6ca358730c8c'
      sender.date_of_birth = '2000-01-01'
      sender
    end

    it 'serializes reference to the reference key' do
      expect(wire(sender)).to eq({ 'reference' => '0fc88634-78c1-4286-9cb6-6ca358730c8c',
                                   'date_of_birth' => '2000-01-01' })
    end

    it 'sends reference under account_funding_transaction.sender.reference' do
      aft = CheckoutSdk::Payments::PaymentSetupAccountFundingTransaction.new
      aft.sender = sender

      expect(wire(aft).dig('sender', 'reference')).to eq('0fc88634-78c1-4286-9cb6-6ca358730c8c')
    end

    it 'round trips reference through the API client' do
      response = parse_json(CheckoutSdk::JsonSerializer.to_custom_hash(sender).to_json)

      expect(response.reference).to eq('0fc88634-78c1-4286-9cb6-6ca358730c8c')
      expect(response.date_of_birth).to eq('2000-01-01')
    end

    it 'reads reference from the swagger example' do
      body = '{"account_funding_transaction":{"sender":{"date_of_birth":"2000-01-01T00:00:00.0000000",' \
             '"reference":"0fc88634-78c1-4286-9cb6-6ca358730c8c"}}}'

      read = parse_json(body).account_funding_transaction.sender

      expect(read.reference).to eq('0fc88634-78c1-4286-9cb6-6ca358730c8c')
      expect(read.date_of_birth).to eq('2000-01-01T00:00:00.0000000')
    end
  end

  describe 'deprecated account funding transaction fields' do
    it 'still serializes the deprecated sender fields under their keys, next to the spec fields' do
      address = CheckoutSdk::Common::Address.new
      address.city = 'London'
      sender = CheckoutSdk::Payments::AccountFundingTransactionSender.new
      sender.first_name = 'John'
      sender.last_name = 'Smith'
      sender.country_of_birth = CheckoutSdk::Common::Country::GB
      sender.nationality = CheckoutSdk::Common::Country::GB
      sender.address = address
      sender.reference = 'sender-ref'

      expect(wire(sender)).to eq({ 'first_name' => 'John', 'last_name' => 'Smith', 'country_of_birth' => 'GB',
                                   'nationality' => 'GB', 'address' => { 'city' => 'London' },
                                   'reference' => 'sender-ref' })
    end

    it 'still serializes the deprecated recipient account_type under its key, next to the spec fields' do
      recipient = CheckoutSdk::Payments::AccountFundingTransactionRecipient.new
      recipient.account_type = 'checking'
      recipient.account_number = '5555554444'

      expect(wire(recipient)).to eq({ 'account_type' => 'checking', 'account_number' => '5555554444' })
    end
  end
end
