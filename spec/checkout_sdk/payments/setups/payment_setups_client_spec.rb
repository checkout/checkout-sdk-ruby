RSpec.describe CheckoutSdk::Payments do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Payments::PaymentSetupsClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_payment_setup' do
    it 'POSTs an opaque request object to payments/setups' do
      request = double('request')
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups', 'secret_key', request).and_return('response')
      expect(client.create_payment_setup(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'amount' => 1000, 'currency' => 'GBP' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups', 'secret_key', hash_request).and_return('response')
      expect(client.create_payment_setup(hash_request)).to eq('response')
    end
  end

  describe '#update_payment_setup' do
    it 'PUTs payments/setups/{id}' do
      request = double('request')
      expect(api_client_mock).to receive(:invoke_put)
        .with('payments/setups/ps_1', 'secret_key', request).and_return('response')
      expect(client.update_payment_setup('ps_1', request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'amount' => 2000 }
      expect(api_client_mock).to receive(:invoke_put)
        .with('payments/setups/ps_1', 'secret_key', hash_request).and_return('response')
      expect(client.update_payment_setup('ps_1', hash_request)).to eq('response')
    end
  end

  describe '#get_payment_setup' do
    it 'GETs payments/setups/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('payments/setups/ps_1', 'secret_key').and_return('response')
      expect(client.get_payment_setup('ps_1')).to eq('response')
    end
  end

  describe '#confirm_payment_setup' do
    it 'POSTs payments/setups/{id}/confirm/{payment_method_option_id}' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups/ps_1/confirm/pmo_1', 'secret_key').and_return('response')
      expect(client.confirm_payment_setup('ps_1', 'pmo_1')).to eq('response')
    end
  end
end
