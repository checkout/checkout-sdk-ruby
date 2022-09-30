RSpec.describe CheckoutSdk::Previous::Apm::KlarnaClient do

  before(:example) {
    @environment_mock = double('environment')
    @credentials_mock = double('credentials')
    @api_client_mock = double('apì_client')
    @configuration_mock = double('configuration')
    @klarna_client = CheckoutSdk::Previous::Apm::KlarnaClient.new @api_client_mock, @configuration_mock

    expect(@environment_mock).to receive(:is_sandbox).and_return(true)
    expect(@configuration_mock).to receive(:environment).and_return(@environment_mock)
    expect(@credentials_mock).to receive(:get_authorization).and_return('secret_key')
    expect(@configuration_mock).to receive(:credentials).and_return(@credentials_mock)
  }

  describe '.create_credit_session' do
    context 'when creating session with valid parameters' do
      it 'creates credit session correctly' do
        request = CheckoutSdk::Previous::Apm::CreditSessionRequest.new

        expect(@api_client_mock).to receive(:invoke_post)
                                     .with('klarna-external/credit-sessions',
                                           'secret_key',
                                           request)
                                     .and_return('response')

        expect(@klarna_client.create_credit_session(request)).to eq('response')
      end
    end
  end

  describe '.get_credit_session' do
    context 'when trying to fetch credit session' do
      it 'retrieves credit session' do
        expect(@api_client_mock).to receive(:invoke_get)
                                     .with('klarna-external/credit-sessions/session_id',
                                           'secret_key')
                                     .and_return('response')

        expect(@klarna_client.get_credit_session('session_id')).to eq('response')
      end
    end
  end

  describe '.capture_payment' do
    context 'when capturing valid payment' do
      it 'captures payment' do
        request = CheckoutSdk::Previous::Apm::OrderCaptureRequest.new

        expect(@api_client_mock).to receive(:invoke_post)
                                     .with('klarna-external/orders/payment_id/captures',
                                           'secret_key',
                                           request)
                                     .and_return('response')

        expect(@klarna_client.capture_payment('payment_id', request)).to eq('response')
      end
    end
  end

  describe '.void_payment' do
    context 'when voiding valid payment' do
      it 'voids payment' do
        request = CheckoutSdk::Payments::VoidRequest.new

        expect(@api_client_mock).to receive(:invoke_post)
                                     .with('klarna-external/orders/payment_id/voids',
                                           'secret_key',
                                           request)
                                     .and_return('response')

        expect(@klarna_client.void_payment('payment_id', request)).to eq('response')
      end
    end
  end
end
