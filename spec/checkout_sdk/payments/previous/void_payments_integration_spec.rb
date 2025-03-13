RSpec.describe CheckoutSdk::Previous::Payments do
  include Previous::PaymentsHelper

  before(:all) do
    @api = previous_sdk
  end

  describe '.void_payment', skip: 'unavailable' do
    context 'when attempt payment' do
      it 'void payment' do
        payment_response = make_card_payment

        request = CheckoutSdk::Payments::VoidRequest.new
        request.reference = SecureRandom.uuid

        response = @api.payments.void_payment(payment_response.id, request)
        assert_response(response, %w[reference
                                     action_id
                                     _links])
      end

      it 'void payment idempotent' do
        payment_response = make_card_payment

        request = CheckoutSdk::Payments::VoidRequest.new

        request.reference = SecureRandom.uuid
        idempotency_key = new_idempotency_key

        proc = lambda { @api.payments.void_payment(payment_response.id, request, idempotency_key) }
        proc2 = lambda { @api.payments.void_payment(payment_response.id, request, idempotency_key) }

        void_response_1 = retriable(proc)
        void_response_2 = retriable(proc2)
        expect(void_response_1.action_id).to eq(void_response_2.action_id)
      end
    end
  end
end
