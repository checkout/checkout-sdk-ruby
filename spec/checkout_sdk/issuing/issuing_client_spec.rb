RSpec.describe CheckoutSdk::Issuing do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Issuing::IssuingClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization)
      .with(CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH).and_return('secret_key_or_oauth')
    allow(credentials_mock).to receive(:get_authorization)
      .with(CheckoutSdk::AuthorizationType::OAUTH).and_return('oauth')
  end

  describe '#request_cardholder_access_token' do
    it 'POSTs typed DTO to issuing/access/connect/token using OAuth' do
      request = CheckoutSdk::Issuing::CardholderAccessTokenRequest.new
      request.client_id = 'cid'
      request.client_secret = 'csec'
      request.cardholder_id = 'crh_abc'
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/access/connect/token', 'oauth', request).and_return('response')
      expect(client.request_cardholder_access_token(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = {
        'grant_type' => 'client_credentials',
        'client_id' => 'cid',
        'client_secret' => 'csec',
        'cardholder_id' => 'crh_abc'
      }
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/access/connect/token', 'oauth', hash_request).and_return('response')
      expect(client.request_cardholder_access_token(hash_request)).to eq('response')
    end
  end

  describe '#simulate_oob_authentication' do
    it 'POSTs typed DTO to issuing/simulate/oob/authentication using OAuth' do
      request = CheckoutSdk::Issuing::OobAuthenticationRequest.new
      request.card_id = 'crd_xyz'
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/simulate/oob/authentication', 'oauth', request).and_return('response')
      expect(client.simulate_oob_authentication(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'card_id' => 'crd_xyz' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/simulate/oob/authentication', 'oauth', hash_request).and_return('response')
      expect(client.simulate_oob_authentication(hash_request)).to eq('response')
    end
  end
end
