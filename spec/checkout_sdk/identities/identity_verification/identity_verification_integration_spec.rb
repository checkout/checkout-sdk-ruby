RSpec.describe CheckoutSdk::Identities::IdentityVerification do
  skip 'Requires sandbox credentials with Identity Verification entitlement' do
    let(:client) { default_sdk.identity_verification }

    describe '#create_identity_verification' do
      it 'creates an identity verification' do
        request = CheckoutSdk::Identities::IdentityVerification::IdentityVerificationRequest.new
        request.applicant_id = ENV['CHECKOUT_APPLICANT_ID']
        request.user_journey_id = ENV['CHECKOUT_USER_JOURNEY_ID']
        request.declared_data = CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData.new
        request.declared_data.name = Helpers::DataFactory::NAME
        response = client.create_identity_verification(request)
        expect(response).not_to be_nil
      end
    end

    describe '#create_and_open_idv' do
      it 'creates and returns a hosted URL' do
        request = CheckoutSdk::Identities::IdentityVerification::IdentityVerificationRequest.new
        request.applicant_id = ENV['CHECKOUT_APPLICANT_ID']
        request.user_journey_id = ENV['CHECKOUT_USER_JOURNEY_ID']
        request.declared_data = CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData.new
        request.declared_data.name = Helpers::DataFactory::NAME
        response = client.create_and_open_idv(request)
        expect(response).not_to be_nil
      end
    end

    describe '#get_identity_verification' do
      it 'retrieves an identity verification' do
        response = client.get_identity_verification(ENV['CHECKOUT_IDENTITY_VERIFICATION_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#anonymize_identity_verification' do
      it 'anonymizes the verification' do
        response = client.anonymize_identity_verification(ENV['CHECKOUT_IDENTITY_VERIFICATION_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#get_identity_verification_attempts' do
      it 'lists the verification attempts' do
        response = client.get_identity_verification_attempts(ENV['CHECKOUT_IDENTITY_VERIFICATION_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#get_identity_verification_attempt' do
      it 'retrieves a single attempt' do
        response = client.get_identity_verification_attempt(ENV['CHECKOUT_IDENTITY_VERIFICATION_ID'], ENV['CHECKOUT_IDENTITY_VERIFICATION_ATTEMPT_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#get_identity_verification_pdf_report' do
      it 'retrieves the verification PDF report' do
        response = client.get_identity_verification_pdf_report(ENV['CHECKOUT_IDENTITY_VERIFICATION_ID'])
        expect(response).not_to be_nil
      end
    end
  end
end
