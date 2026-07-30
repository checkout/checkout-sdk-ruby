# frozen_string_literal: true

RSpec.describe CheckoutSdk::Identities::AddressDocumentVerification do
  skip 'Requires sandbox credentials with Address Document Verification entitlement' do
    let(:client) { default_sdk.address_document_verification }

    describe '#create_address_document_verification' do
      it 'creates an address document verification' do
        request = CheckoutSdk::Identities::AddressDocumentVerification::AddressDocumentVerificationRequest.new
        request.applicant_id = ENV.fetch('CHECKOUT_APPLICANT_ID', nil)
        request.user_journey_id = ENV.fetch('CHECKOUT_USER_JOURNEY_ID', nil)
        response = client.create_address_document_verification(request)
        expect(response).not_to be_nil
      end
    end

    describe '#get_address_document_verification' do
      it 'retrieves an address document verification' do
        response = client.get_address_document_verification(ENV.fetch('CHECKOUT_ADV_ID', nil))
        expect(response).not_to be_nil
      end
    end

    describe '#anonymize_address_document_verification' do
      it 'anonymizes the verification' do
        response = client.anonymize_address_document_verification(ENV.fetch('CHECKOUT_ADV_ID', nil))
        expect(response).not_to be_nil
      end
    end

    describe '#create_address_document_verification_attempt' do
      it 'creates an attempt' do
        request = CheckoutSdk::Identities::AddressDocumentVerification::AddressDocumentVerificationAttemptRequest.new
        request.document = ENV.fetch('CHECKOUT_ADV_DOCUMENT', nil)
        response = client.create_address_document_verification_attempt(ENV.fetch('CHECKOUT_ADV_ID', nil), request)
        expect(response).not_to be_nil
      end
    end

    describe '#get_address_document_verification_attempts' do
      it 'lists the verification attempts' do
        response = client.get_address_document_verification_attempts(ENV.fetch('CHECKOUT_ADV_ID', nil))
        expect(response).not_to be_nil
      end
    end

    describe '#get_address_document_verification_attempt' do
      it 'retrieves a single attempt' do
        response = client.get_address_document_verification_attempt(ENV.fetch('CHECKOUT_ADV_ID', nil),
                                                                    ENV.fetch('CHECKOUT_ADV_ATTEMPT_ID', nil))
        expect(response).not_to be_nil
      end
    end

    describe '#get_address_document_verification_pdf_report' do
      it 'retrieves the PDF report' do
        response = client.get_address_document_verification_pdf_report(ENV.fetch('CHECKOUT_ADV_ID', nil))
        expect(response).not_to be_nil
      end
    end
  end
end
