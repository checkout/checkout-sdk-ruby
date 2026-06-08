RSpec.describe CheckoutSdk::Payments do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Payments::PaymentSessionsClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_and_complete_payment_sessions' do
    it 'POSTs to payment-sessions/complete' do
      req = double('request')
      expect(api_client_mock).to receive(:invoke_post)
        .with('payment-sessions/complete', 'secret_key', req).and_return('r')
      expect(client.create_and_complete_payment_sessions(req)).to eq('r')
    end
  end
end
