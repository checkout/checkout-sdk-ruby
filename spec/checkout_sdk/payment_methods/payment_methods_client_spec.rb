RSpec.describe CheckoutSdk::PaymentMethods do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::PaymentMethods::PaymentMethodsClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#get_payment_methods' do
    it 'GETs payment-methods with typed query' do
      query = CheckoutSdk::PaymentMethods::PaymentMethodsQuery.new
      query.processing_channel_id = 'pc_xxx'
      expect(api_client_mock).to receive(:invoke_get)
        .with('payment-methods', 'secret_key', query)
        .and_return('response')
      expect(client.get_payment_methods(query)).to eq('response')
    end

    it 'also accepts a raw Hash query' do
      hash_query = { 'processing_channel_id' => 'pc_xxx' }
      expect(api_client_mock).to receive(:invoke_get)
        .with('payment-methods', 'secret_key', hash_query)
        .and_return('response')
      expect(client.get_payment_methods(hash_query)).to eq('response')
    end
  end
end
