RSpec.describe CheckoutSdk::Payments do
  include PaymentsHelper

  describe '.refund_payment' do
    context 'when refunding a payment' do
      it 'should refund correctly with balances' do
        payment_response = make_card_payment(capture: true, capture_on: Time.now.iso8601)

        request = CheckoutSdk::Payments::RefundRequest.new
        request.reference = SecureRandom.uuid
        request.amount = 2

        proc = lambda { default_sdk.payments.refund_payment(payment_response.id, request) }

        response = retriable(proc)
        assert_response(response, %w[reference
                                     action_id
                                     _links])

        payment_details = default_sdk.payments.get_payment_details(payment_response.id)
        assert_response(payment_details, %w[balances.total_authorized
                                            balances.total_captured
                                            balances.total_refunded])
      end

      it 'should refund idempotent correctly' do
        payment_response = make_card_payment(capture: true, capture_on: Time.now.iso8601)

        request = CheckoutSdk::Payments::RefundRequest.new
        request.reference = SecureRandom.uuid
        request.amount = 2
        idempotency_key = new_idempotency_key

        proc = lambda { default_sdk.payments.refund_payment(payment_response.id, request, idempotency_key) }
        proc2 = lambda { default_sdk.payments.refund_payment(payment_response.id, request, idempotency_key) }

        refund_response_1 = retriable(proc)
        refund_response_2 = retriable(proc2)
        expect(refund_response_1.action_id).to eq(refund_response_2.action_id)
      end
    end
  end
end
