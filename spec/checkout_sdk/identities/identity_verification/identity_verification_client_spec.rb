RSpec.describe CheckoutSdk::Identities::IdentityVerification do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Identities::IdentityVerification::IdentityVerificationClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_and_open_idv' do
    it 'POSTs typed DTO to create-and-open-idv' do
      request = CheckoutSdk::Identities::IdentityVerification::IdentityVerificationRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('create-and-open-idv', 'secret_key', request).and_return('response')
      expect(client.create_and_open_idv(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'applicant_id' => 'aplt_x', 'user_journey_id' => 'usj_x' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('create-and-open-idv', 'secret_key', hash_request).and_return('response')
      expect(client.create_and_open_idv(hash_request)).to eq('response')
    end
  end

  describe '#create_identity_verification' do
    it 'POSTs typed DTO to identity-verifications' do
      request = CheckoutSdk::Identities::IdentityVerification::IdentityVerificationRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('identity-verifications', 'secret_key', request).and_return('response')
      expect(client.create_identity_verification(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'applicant_id' => 'aplt_x' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('identity-verifications', 'secret_key', hash_request).and_return('response')
      expect(client.create_identity_verification(hash_request)).to eq('response')
    end
  end

  describe '#get_identity_verification' do
    it 'GETs identity-verifications/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('identity-verifications/idv_x', 'secret_key').and_return('response')
      expect(client.get_identity_verification('idv_x')).to eq('response')
    end
  end

  describe '#anonymize_identity_verification' do
    it 'POSTs identity-verifications/{id}/anonymize' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('identity-verifications/idv_x/anonymize', 'secret_key').and_return('response')
      expect(client.anonymize_identity_verification('idv_x')).to eq('response')
    end
  end

  describe '#get_identity_verification_attempts' do
    it 'GETs identity-verifications/{id}/attempts' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('identity-verifications/idv_x/attempts', 'secret_key').and_return('response')
      expect(client.get_identity_verification_attempts('idv_x')).to eq('response')
    end
  end

  describe '#get_identity_verification_attempt' do
    it 'GETs identity-verifications/{id}/attempts/{attempt_id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('identity-verifications/idv_x/attempts/att_1', 'secret_key').and_return('response')
      expect(client.get_identity_verification_attempt('idv_x', 'att_1')).to eq('response')
    end
  end

  describe '#get_identity_verification_pdf_report' do
    it 'GETs identity-verifications/{id}/pdf-report' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('identity-verifications/idv_x/pdf-report', 'secret_key').and_return('response')
      expect(client.get_identity_verification_pdf_report('idv_x')).to eq('response')
    end
  end

  describe '#get_identity_verification_attempt_assets' do
    it 'GETs identity-verifications/{id}/attempts/{attempt_id}/assets with query params' do
      query = { skip: 0, limit: 10 }
      expect(api_client_mock).to receive(:invoke_get)
        .with('identity-verifications/idv_x/attempts/att_1/assets', 'secret_key', query).and_return('response')
      expect(client.get_identity_verification_attempt_assets('idv_x', 'att_1', query)).to eq('response')
    end

    it 'GETs the assets path with no query params' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('identity-verifications/idv_x/attempts/att_1/assets', 'secret_key', nil).and_return('response')
      expect(client.get_identity_verification_attempt_assets('idv_x', 'att_1')).to eq('response')
    end
  end
end
