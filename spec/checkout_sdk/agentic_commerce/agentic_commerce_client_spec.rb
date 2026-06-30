RSpec.describe CheckoutSdk::AgenticCommerce do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::AgenticCommerce::AgenticCommerceClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_delegated_payment_token' do
    it 'POSTs typed DTO to agentic_commerce/delegate_payment with idempotency_key' do
      request = CheckoutSdk::AgenticCommerce::DelegatedPaymentRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('agentic_commerce/delegate_payment', 'secret_key', request, 'idem-1')
        .and_return('response')
      expect(client.create_delegated_payment_token(request, 'idem-1')).to eq('response')
    end

    it 'POSTs without idempotency_key when omitted' do
      request = CheckoutSdk::AgenticCommerce::DelegatedPaymentRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('agentic_commerce/delegate_payment', 'secret_key', request, nil)
        .and_return('response')
      expect(client.create_delegated_payment_token(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'metadata' => { 'order_id' => 'ord_1' } }
      expect(api_client_mock).to receive(:invoke_post)
        .with('agentic_commerce/delegate_payment', 'secret_key', hash_request, nil)
        .and_return('response')
      expect(client.create_delegated_payment_token(hash_request)).to eq('response')
    end
  end
end
