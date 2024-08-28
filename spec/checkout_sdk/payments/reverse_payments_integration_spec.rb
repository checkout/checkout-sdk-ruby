RSpec.describe CheckoutSdk::Payments do
  include PaymentsHelper

  skip 'unavailable' do
    describe '.reverse_payment' do
      context 'when attempt payment' do
        it 'reverse payment' do
          payment_response = make_card_payment

          request = CheckoutSdk::Payments::ReverseRequest.new
          request.reference = SecureRandom.uuid

          response = default_sdk.payments.reverse_payment(payment_response.id, request)
          assert_response(response, %w[reference
                                     action_id
                                     _links])
        end

        it 'reverse payment idempotent' do
          payment_response = make_card_payment

          request = CheckoutSdk::Payments::ReverseRequest.new

          request.reference = SecureRandom.uuid
          idempotency_key = new_idempotency_key

          proc = lambda { default_sdk.payments.reverse_payment(payment_response.id, request, idempotency_key) }
          proc2 = lambda { default_sdk.payments.reverse_payment(payment_response.id, request, idempotency_key) }

          reverse_response_1 = retriable(proc)
          reverse_response_2 = retriable(proc2)
          expect(reverse_response_1.action_id).to eq(reverse_response_2.action_id)
        end
      end
    end
  end
end
