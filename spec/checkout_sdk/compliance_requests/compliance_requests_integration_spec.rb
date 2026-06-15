RSpec.describe CheckoutSdk::ComplianceRequests do
  skip 'Requires a sandbox payment with a pending compliance request' do
    let(:client) { default_sdk.compliance_requests }
    let(:payment_id) { ENV['CHECKOUT_COMPLIANCE_PAYMENT_ID'] }

    describe '#get_compliance_request' do
      it 'retrieves a compliance request' do
        response = client.get_compliance_request(payment_id)
        expect(response).not_to be_nil
      end
    end

    describe '#respond_to_compliance_request' do
      it 'responds to a compliance request' do
        request = CheckoutSdk::ComplianceRequests::ComplianceResponseRequest.new
        request.comments = 'Integration test response'
        request.fields = CheckoutSdk::ComplianceRequests::ComplianceRequestRespondedFields.new
        sender_field = CheckoutSdk::ComplianceRequests::ComplianceRequestRespondedField.new
        sender_field.name = 'date_of_birth'
        sender_field.value = '1990-01-01'
        sender_field.not_available = false
        request.fields.sender = [sender_field]

        response = client.respond_to_compliance_request(payment_id, request)
        expect(response).not_to be_nil
      end
    end
  end
end
