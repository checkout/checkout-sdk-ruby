RSpec.describe 'Identities — create attempt' do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe 'FaceAuthenticationClient#create_face_authentication_attempt' do
    let(:client) { CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationClient.new(api_client_mock, configuration_mock) }

    it 'POSTs face-authentications/{id}/attempts' do
      req = CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationAttemptRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('face-authentications/fa_x/attempts', 'secret_key', req).and_return('r')
      expect(client.create_face_authentication_attempt('fa_x', req)).to eq('r')
    end
  end

  describe 'IdentityVerificationClient#create_identity_verification_attempt' do
    let(:client) { CheckoutSdk::Identities::IdentityVerification::IdentityVerificationClient.new(api_client_mock, configuration_mock) }

    it 'POSTs identity-verifications/{id}/attempts' do
      req = CheckoutSdk::Identities::IdentityVerification::IdentityVerificationAttemptRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('identity-verifications/idv_x/attempts', 'secret_key', req).and_return('r')
      expect(client.create_identity_verification_attempt('idv_x', req)).to eq('r')
    end
  end

  describe 'IdDocumentVerificationClient#create_id_document_verification_attempt' do
    let(:client) { CheckoutSdk::Identities::IdDocumentVerification::IdDocumentVerificationClient.new(api_client_mock, configuration_mock) }

    it 'POSTs id-document-verifications/{id}/attempts' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('id-document-verifications/idv_x/attempts', 'secret_key', nil).and_return('r')
      expect(client.create_id_document_verification_attempt('idv_x')).to eq('r')
    end
  end
end
