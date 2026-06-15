RSpec.describe CheckoutSdk::NetworkTokens do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::NetworkTokens::NetworkTokensClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#provision_network_token' do
    it 'POSTs typed DTO to network-tokens' do
      request = CheckoutSdk::NetworkTokens::ProvisionNetworkTokenRequest.new
      request.source = CheckoutSdk::NetworkTokens::NetworkTokenSourceId.new
      request.source.id = 'src_xxx'
      expect(api_client_mock).to receive(:invoke_post)
        .with('network-tokens', 'secret_key', request)
        .and_return('response')
      expect(client.provision_network_token(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'source' => { 'type' => 'id', 'id' => 'src_xxx' } }
      expect(api_client_mock).to receive(:invoke_post)
        .with('network-tokens', 'secret_key', hash_request)
        .and_return('response')
      expect(client.provision_network_token(hash_request)).to eq('response')
    end
  end

  describe '#get_network_token' do
    it 'GETs network-tokens/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('network-tokens/nt_123', 'secret_key')
        .and_return('response')
      expect(client.get_network_token('nt_123')).to eq('response')
    end
  end

  describe '#request_cryptograms' do
    it 'POSTs typed DTO to network-tokens/{id}/cryptograms' do
      request = CheckoutSdk::NetworkTokens::NetworkTokenCryptogramRequest.new
      request.transaction_type = 'ecom'
      expect(api_client_mock).to receive(:invoke_post)
        .with('network-tokens/nt_123/cryptograms', 'secret_key', request)
        .and_return('response')
      expect(client.request_cryptograms('nt_123', request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'transaction_type' => 'ecom' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('network-tokens/nt_123/cryptograms', 'secret_key', hash_request)
        .and_return('response')
      expect(client.request_cryptograms('nt_123', hash_request)).to eq('response')
    end
  end

  describe '#delete_network_token' do
    it 'PATCHes network-tokens/{id}/delete' do
      expect(api_client_mock).to receive(:invoke_patch)
        .with('network-tokens/nt_123/delete', 'secret_key')
        .and_return('response')
      expect(client.delete_network_token('nt_123')).to eq('response')
    end
  end
end
