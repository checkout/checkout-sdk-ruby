RSpec.describe CheckoutSdk::Identities::AmlScreening do
  skip 'Requires sandbox credentials with AML Screening entitlement' do
    let(:client) { default_sdk.aml_screening }

    describe '#create_aml_verification' do
      it 'creates an AML verification' do
        request = CheckoutSdk::Identities::AmlScreening::AmlVerificationRequest.new
        request.applicant_id = ENV['CHECKOUT_APPLICANT_ID']
        request.search_parameters = CheckoutSdk::Identities::AmlScreening::AmlSearchParameters.new
        request.search_parameters.configuration_identifier = ENV['CHECKOUT_AML_CONFIG_ID']
        request.monitored = false
        response = client.create_aml_verification(request)
        expect(response).not_to be_nil
      end
    end

    describe '#get_aml_verification' do
      it 'retrieves an AML verification' do
        response = client.get_aml_verification(ENV['CHECKOUT_AML_VERIFICATION_ID'])
        expect(response).not_to be_nil
      end
    end
  end
end
