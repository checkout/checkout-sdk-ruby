RSpec.describe CheckoutSdk::Identities::IdDocumentVerification do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Identities::IdDocumentVerification::IdDocumentVerificationClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_id_document_verification' do
    it 'POSTs typed DTO to id-document-verifications' do
      request = CheckoutSdk::Identities::IdDocumentVerification::IdDocumentVerificationRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('id-document-verifications', 'secret_key', request).and_return('response')
      expect(client.create_id_document_verification(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'applicant_id' => 'aplt_x' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('id-document-verifications', 'secret_key', hash_request).and_return('response')
      expect(client.create_id_document_verification(hash_request)).to eq('response')
    end
  end

  describe '#get_id_document_verification' do
    it 'GETs id-document-verifications/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('id-document-verifications/idv_x', 'secret_key').and_return('response')
      expect(client.get_id_document_verification('idv_x')).to eq('response')
    end
  end

  describe '#anonymize_id_document_verification' do
    it 'POSTs id-document-verifications/{id}/anonymize' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('id-document-verifications/idv_x/anonymize', 'secret_key').and_return('response')
      expect(client.anonymize_id_document_verification('idv_x')).to eq('response')
    end
  end

  describe '#get_id_document_verification_attempts' do
    it 'GETs id-document-verifications/{id}/attempts' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('id-document-verifications/idv_x/attempts', 'secret_key').and_return('response')
      expect(client.get_id_document_verification_attempts('idv_x')).to eq('response')
    end
  end

  describe '#get_id_document_verification_attempt' do
    it 'GETs id-document-verifications/{id}/attempts/{attempt_id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('id-document-verifications/idv_x/attempts/att_1', 'secret_key').and_return('response')
      expect(client.get_id_document_verification_attempt('idv_x', 'att_1')).to eq('response')
    end
  end

  describe '#get_id_document_verification_pdf_report' do
    it 'GETs id-document-verifications/{id}/pdf-report' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('id-document-verifications/idv_x/pdf-report', 'secret_key').and_return('response')
      expect(client.get_id_document_verification_pdf_report('idv_x')).to eq('response')
    end
  end
end
