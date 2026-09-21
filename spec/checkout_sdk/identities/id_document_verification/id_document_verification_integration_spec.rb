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

    describe '#get_id_document_verification_attempts with pagination' do
      it 'honours skip and limit' do
        query = CheckoutSdk::Identities::IdvAttemptsQueryFilter.new
        query.limit = 1
        response = client.get_id_document_verification_attempts(ENV['CHECKOUT_IDV_DOC_ID'], query)
        expect(response).not_to be_nil
        expect(response.limit).to eq(1)
      end
    end

    describe '#get_id_document_verification_attempt_assets' do
      it 'retrieves the uploaded document images' do
        query = CheckoutSdk::Identities::IdvAttemptAssetsQueryFilter.new
        query.limit = 10
        response = client.get_id_document_verification_attempt_assets(
          ENV['CHECKOUT_IDV_DOC_ID'],
          ENV['CHECKOUT_IDV_DOC_ATTEMPT_ID'],
          query
        )
        expect(response).not_to be_nil
        response.data.each do |asset|
          expect(%w[document_front_image document_back_image]).to include(asset.type)
          expect(asset._links.asset_url.href).not_to be_nil
        end
      end
    end
  end
end
