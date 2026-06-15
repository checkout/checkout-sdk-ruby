RSpec.describe CheckoutSdk::AgenticCommerce do
  skip 'Requires a sandbox merchant with Agentic Commerce (Beta) enabled' do
    let(:client) { default_sdk.agentic_commerce }

    describe '#create_delegated_payment_token' do
      it 'creates a delegated payment token for a single purchase' do
        # Card payment method — swagger required: type, card_number_type, number, metadata
        card = CheckoutSdk::AgenticCommerce::DelegatedPaymentMethodCard.new
        card.card_number_type = 'fpan'
        card.number = '4242424242424242'
        card.exp_month = '12'
        card.exp_year = '2030'
        card.name = 'Integration Test'
        card.metadata = { 'merchant_reference' => 'INT-AC-001' }

        # Allowance — swagger required: reason, max_amount, currency, merchant_id,
        # checkout_session_id, expires_at
        allowance = CheckoutSdk::AgenticCommerce::DelegatedPaymentAllowance.new
        allowance.reason = 'one_time'
        allowance.max_amount = 1000
        allowance.currency = 'GBP'
        allowance.merchant_id = ENV['CHECKOUT_AC_MERCHANT_ID']
        allowance.checkout_session_id = ENV['CHECKOUT_AC_SESSION_ID']
        allowance.expires_at = '2026-12-31T23:59:59Z'

        # Billing address — swagger required: name, line_one, city, postal_code, country
        billing = CheckoutSdk::AgenticCommerce::DelegatedPaymentBillingAddress.new
        billing.name = 'Integration Test'
        billing.line_one = '1 Test Street'
        billing.city = 'London'
        billing.postal_code = 'SW1A 1AA'
        billing.country = 'GB'

        # Risk signals — swagger required: type, score, action (array)
        risk = CheckoutSdk::AgenticCommerce::DelegatedPaymentRiskSignal.new
        risk.type = 'card_testing'
        risk.score = 10
        risk.action = 'allow'

        request = CheckoutSdk::AgenticCommerce::DelegatedPaymentRequest.new
        request.payment_method = card
        request.allowance = allowance
        request.billing_address = billing
        request.risk_signals = [risk]
        request.metadata = { 'order_id' => 'INT-AC-001' }

        response = client.create_delegated_payment_token(request, SecureRandom.uuid)
        expect(response).not_to be_nil
      end
    end
  end
end
