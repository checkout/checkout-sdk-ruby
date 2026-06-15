RSpec.describe CheckoutSdk::Payments do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Payments::PaymentsClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#search_payments' do
    it 'POSTs typed DTO to payments/search' do
      req = CheckoutSdk::Payments::PaymentsSearchRequest.new
      req.query = "id:'pay_x'"
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/search', 'secret_key', req).and_return('r')
      expect(client.search_payments(req)).to eq('r')
    end

    it 'also accepts a raw Hash' do
      h = { 'query' => 'reference:ORD-1' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/search', 'secret_key', h).and_return('r')
      expect(client.search_payments(h)).to eq('r')
    end
  end

  describe '#cancel_payment' do
    it 'POSTs typed DTO to payments/{id}/cancellations' do
      req = CheckoutSdk::Payments::CancellationRequest.new
      req.reference = 'ORD-5023'
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/pay_1/cancellations', 'secret_key', req, nil).and_return('r')
      expect(client.cancel_payment('pay_1', req)).to eq('r')
    end

    it 'passes through an idempotency key' do
      req = CheckoutSdk::Payments::CancellationRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/pay_1/cancellations', 'secret_key', req, 'idem-1').and_return('r')
      expect(client.cancel_payment('pay_1', req, 'idem-1')).to eq('r')
    end
  end
end
