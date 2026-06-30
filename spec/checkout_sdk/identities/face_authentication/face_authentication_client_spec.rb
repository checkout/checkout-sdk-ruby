RSpec.describe CheckoutSdk::Identities::FaceAuthentication do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_face_authentication' do
    it 'POSTs typed DTO to face-authentications' do
      request = CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('face-authentications', 'secret_key', request).and_return('response')
      expect(client.create_face_authentication(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'applicant_id' => 'aplt_x' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('face-authentications', 'secret_key', hash_request).and_return('response')
      expect(client.create_face_authentication(hash_request)).to eq('response')
    end
  end

  describe '#get_face_authentication' do
    it 'GETs face-authentications/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('face-authentications/fa_x', 'secret_key').and_return('response')
      expect(client.get_face_authentication('fa_x')).to eq('response')
    end
  end

  describe '#anonymize_face_authentication' do
    it 'POSTs face-authentications/{id}/anonymize' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('face-authentications/fa_x/anonymize', 'secret_key').and_return('response')
      expect(client.anonymize_face_authentication('fa_x')).to eq('response')
    end
  end

  describe '#get_face_authentication_attempts' do
    it 'GETs face-authentications/{id}/attempts' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('face-authentications/fa_x/attempts', 'secret_key').and_return('response')
      expect(client.get_face_authentication_attempts('fa_x')).to eq('response')
    end
  end

  describe '#get_face_authentication_attempt' do
    it 'GETs face-authentications/{id}/attempts/{attempt_id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('face-authentications/fa_x/attempts/att_1', 'secret_key').and_return('response')
      expect(client.get_face_authentication_attempt('fa_x', 'att_1')).to eq('response')
    end
  end

  describe '#get_face_authentication_attempt_assets' do
    it 'GETs face-authentications/{id}/attempts/{attempt_id}/assets with query params' do
      query = { skip: 0, limit: 10 }
      expect(api_client_mock).to receive(:invoke_get)
        .with('face-authentications/fa_x/attempts/att_1/assets', 'secret_key', query).and_return('response')
      expect(client.get_face_authentication_attempt_assets('fa_x', 'att_1', query)).to eq('response')
    end

    it 'GETs the assets path with no query params' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('face-authentications/fa_x/attempts/att_1/assets', 'secret_key', nil).and_return('response')
      expect(client.get_face_authentication_attempt_assets('fa_x', 'att_1')).to eq('response')
    end
  end
end
