RSpec.describe CheckoutSdk::Identities::Applicants do
  skip 'Requires sandbox credentials with Identities entitlement' do
    let(:client) { default_sdk.applicants }

    describe '#create_applicant' do
      it 'creates an applicant' do
        request = CheckoutSdk::Identities::Applicants::CreateApplicantRequest.new
        response = client.create_applicant(request)
        expect(response).not_to be_nil
      end
    end

    describe '#get_applicant' do
      it 'retrieves an applicant' do
        response = client.get_applicant(ENV['CHECKOUT_APPLICANT_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#update_applicant' do
      it 'updates an applicant' do
        request = CheckoutSdk::Identities::Applicants::UpdateApplicantRequest.new
        response = client.update_applicant(ENV['CHECKOUT_APPLICANT_ID'], request)
        expect(response).not_to be_nil
      end
    end

    describe '#anonymize_applicant' do
      it 'anonymizes an applicant' do
        response = client.anonymize_applicant(ENV['CHECKOUT_APPLICANT_ID'])
        expect(response).not_to be_nil
      end
    end
  end
end
