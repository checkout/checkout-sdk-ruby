RSpec.describe CheckoutSdk::AgenticCommerce do
  skip 'Requires a sandbox merchant with Agentic Commerce (Beta) enabled' do
    let(:client) { default_sdk.agentic_commerce }

    describe '#create_delegated_payment_token' do
      it 'creates a delegated payment token for a single purchase' do
        request = CheckoutSdk::AgenticCommerce::DelegatedPaymentRequest.new
        request.payment_method = CheckoutSdk::AgenticCommerce::DelegatedPaymentMethodCard.new
        request.payment_method.number = '4242424242424242'
        request.payment_method.exp_month = '12'
        request.payment_method.exp_year = '2030'
        request.payment_method.name = 'Integration Test'
        request.allowance = CheckoutSdk::AgenticCommerce::DelegatedPaymentAllowance.new
        request.allowance.reason = 'one_time'
        request.allowance.amount = '1000'
        request.allowance.currency = 'GBP'

        response = client.create_delegated_payment_token(request, SecureRandom.uuid)
        expect(response).not_to be_nil
      end
    end
  end
end
