RSpec.describe CheckoutSdk::Payments do
  include PaymentsHelper

  describe '.request_payment' do
    context 'when attempt a payment' do
      it 'make card payment' do
        payment_response = make_card_payment

        assert_response(payment_response, %w[id
                                               processed_on
                                               reference
                                               action_id
                                               response_code
                                               scheme_id
                                               response_summary
                                               status
                                               amount
                                               approved
                                               auth_code
                                               currency
                                               source.type
                                               source.id
                                               source.avs_check
                                               source.cvv_check
                                               source.bin
                                               source.card_category
                                               source.card_type
                                               source.expiry_month
                                               source.expiry_year
                                               source.last4
                                               source.scheme
                                               source.name
                                               source.fingerprint
                                               source.issuer_country
                                               source.product_id
                                               source.product_type
                                               customer
                                               customer.id
                                               customer.name
                                               processing
                                               processing.acquirer_transaction_id
                                               processing.retrieval_reference_number])
        expect(payment_response.source.type).to eq(CheckoutSdk::Common::PaymentSourceType::CARD)
      end

      it 'make 3ds card payment' do
        payment_response = make_3ds_card_payment

        assert_response(payment_response, %w[id
                                             reference
                                             status
                                             3ds
                                             3ds.enrolled
                                             customer
                                             customer.id
                                             customer.name
                                             customer.email])
      end

      it 'make 3ds card payment n3d' do
        payment_response = make_3ds_card_payment(attempt_n3d: true)

        assert_response(payment_response, %w[id
                                               processed_on
                                               reference
                                               action_id
                                               response_code
                                               scheme_id
                                               response_summary
                                               status
                                               amount
                                               approved
                                               auth_code
                                               currency
                                               source.type
                                               source.id
                                               source.avs_check
                                               source.cvv_check
                                               source.bin
                                               source.card_category
                                               source.card_type
                                               source.expiry_month
                                               source.expiry_year
                                               source.last4
                                               source.scheme
                                               source.name
                                               source.fingerprint
                                               source.issuer_country
                                               source.product_id
                                               source.product_type
                                               customer
                                               customer.id
                                               customer.name
                                               processing
                                               processing.acquirer_transaction_id
                                               processing.retrieval_reference_number])
        expect(payment_response.source.type).to eq(CheckoutSdk::Common::PaymentSourceType::CARD)
      end

      it 'make card payment idempotent' do
        key = new_idempotency_key
        payment_response_1 = make_card_payment(idempotency_key: key)
        payment_response_2 = make_card_payment(idempotency_key: key)
        expect(payment_response_1.action_id).to eq(payment_response_2.action_id)
      end
    end
  end
end
