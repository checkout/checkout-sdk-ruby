RSpec.describe CheckoutSdk::Forward do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Forward::ForwardClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_secret' do
    it 'POSTs typed DTO to forward/secrets' do
      req = CheckoutSdk::Forward::CreateSecretRequest.new
      req.name = 'sk_test'
      req.value = 'secret'
      expect(api_client_mock).to receive(:invoke_post)
        .with('forward/secrets', 'secret_key', req).and_return('r')
      expect(client.create_secret(req)).to eq('r')
    end

    it 'also accepts a raw Hash' do
      h = { 'name' => 's', 'value' => 'v' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('forward/secrets', 'secret_key', h).and_return('r')
      expect(client.create_secret(h)).to eq('r')
    end
  end

  describe '#get_secrets' do
    it 'GETs forward/secrets' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('forward/secrets', 'secret_key').and_return('r')
      expect(client.get_secrets).to eq('r')
    end
  end

  describe '#update_secret' do
    it 'PATCHes typed DTO to forward/secrets/{name}' do
      req = CheckoutSdk::Forward::UpdateSecretRequest.new
      expect(api_client_mock).to receive(:invoke_patch)
        .with('forward/secrets/my_name', 'secret_key', req).and_return('r')
      expect(client.update_secret('my_name', req)).to eq('r')
    end
  end

  describe '#delete_secret' do
    it 'DELETEs forward/secrets/{name}' do
      expect(api_client_mock).to receive(:invoke_delete)
        .with('forward/secrets/my_name', 'secret_key').and_return('r')
      expect(client.delete_secret('my_name')).to eq('r')
    end
  end
end
