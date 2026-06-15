RSpec.describe CheckoutSdk::Identities::IdDocumentVerification do
  skip 'Requires sandbox credentials with ID Document Verification entitlement' do
    let(:client) { default_sdk.id_document_verification }

    describe '#create_id_document_verification' do
      it 'creates an ID document verification' do
        request = CheckoutSdk::Identities::IdDocumentVerification::IdDocumentVerificationRequest.new
        response = client.create_id_document_verification(request)
        expect(response).not_to be_nil
      end
    end

    describe '#get_id_document_verification' do
      it 'retrieves an ID document verification' do
        response = client.get_id_document_verification(ENV['CHECKOUT_IDV_DOC_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#anonymize_id_document_verification' do
      it 'anonymizes the verification' do
        response = client.anonymize_id_document_verification(ENV['CHECKOUT_IDV_DOC_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#get_id_document_verification_attempts' do
      it 'lists the verification attempts' do
        response = client.get_id_document_verification_attempts(ENV['CHECKOUT_IDV_DOC_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#get_id_document_verification_attempt' do
      it 'retrieves a single attempt' do
        response = client.get_id_document_verification_attempt(ENV['CHECKOUT_IDV_DOC_ID'], ENV['CHECKOUT_IDV_DOC_ATTEMPT_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#get_id_document_verification_pdf_report' do
      it 'retrieves the verification PDF report' do
        response = client.get_id_document_verification_pdf_report(ENV['CHECKOUT_IDV_DOC_ID'])
        expect(response).not_to be_nil
      end
    end
  end
end
