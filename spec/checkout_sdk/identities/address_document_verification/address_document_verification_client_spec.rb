# frozen_string_literal: true

RSpec.describe CheckoutSdk::Identities::AddressDocumentVerification do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) do
    CheckoutSdk::Identities::AddressDocumentVerification::AddressDocumentVerificationClient.new(api_client_mock,
                                                                                                configuration_mock)
  end

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_address_document_verification' do
    it 'POSTs typed DTO to address-document-verifications' do
      request = CheckoutSdk::Identities::AddressDocumentVerification::AddressDocumentVerificationRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('address-document-verifications', 'secret_key', request).and_return('response')
      expect(client.create_address_document_verification(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'applicant_id' => 'aplt_x', 'user_journey_id' => 'usj_x' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('address-document-verifications', 'secret_key', hash_request).and_return('response')
      expect(client.create_address_document_verification(hash_request)).to eq('response')
    end
  end

  describe '#get_address_document_verification' do
    it 'GETs address-document-verifications/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('address-document-verifications/adv_x', 'secret_key').and_return('response')
      expect(client.get_address_document_verification('adv_x')).to eq('response')
    end
  end

  describe '#anonymize_address_document_verification' do
    it 'POSTs address-document-verifications/{id}/anonymize' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('address-document-verifications/adv_x/anonymize', 'secret_key').and_return('response')
      expect(client.anonymize_address_document_verification('adv_x')).to eq('response')
    end
  end

  describe '#create_address_document_verification_attempt' do
    it 'POSTs typed DTO to address-document-verifications/{id}/attempts' do
      request = CheckoutSdk::Identities::AddressDocumentVerification::AddressDocumentVerificationAttemptRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('address-document-verifications/adv_x/attempts', 'secret_key', request).and_return('response')
      expect(client.create_address_document_verification_attempt('adv_x', request)).to eq('response')
    end
  end

  describe '#get_address_document_verification_attempts' do
    it 'GETs address-document-verifications/{id}/attempts' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('address-document-verifications/adv_x/attempts', 'secret_key').and_return('response')
      expect(client.get_address_document_verification_attempts('adv_x')).to eq('response')
    end
  end

  describe '#get_address_document_verification_attempt' do
    it 'GETs address-document-verifications/{id}/attempts/{attempt_id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('address-document-verifications/adv_x/attempts/adva_1', 'secret_key').and_return('response')
      expect(client.get_address_document_verification_attempt('adv_x', 'adva_1')).to eq('response')
    end
  end

  describe '#get_address_document_verification_pdf_report' do
    it 'GETs address-document-verifications/{id}/pdf-report' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('address-document-verifications/adv_x/pdf-report', 'secret_key').and_return('response')
      expect(client.get_address_document_verification_pdf_report('adv_x')).to eq('response')
    end
  end
end
