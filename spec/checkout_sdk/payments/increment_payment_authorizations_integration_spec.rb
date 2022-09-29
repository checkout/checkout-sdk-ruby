RSpec.describe CheckoutSdk::Payments do
  include PaymentsHelper

  describe '.increment_payment_authorization' do
    context 'when making a payment authorization' do
      it 'increments payment correctly' do
        payment_response = make_authorization_payment

        request = CheckoutSdk::Payments::AuthorizationRequest.new
        request.amount = 5
        request.reference = SecureRandom.uuid

        response = default_sdk.payments.increment_payment_authorization(payment_response.id, request)

        assert_response(response, %w[amount
                                     action_id
                                     currency
                                     response_code
                                     response_summary
                                     expires_on
                                     processed_on
                                     balances
                                     response_summary
                                     risk
                                     _links])
      end

      it 'make increment payment idempotent' do
        payment_response = make_authorization_payment

        request = CheckoutSdk::Payments::AuthorizationRequest.new
        request.amount = 5
        request.reference = SecureRandom.uuid

        idempotency_key = new_idempotency_key

        increment_1 = default_sdk.payments.increment_payment_authorization(payment_response.id,
                                                                                  request,
                                                                                  idempotency_key)

        assert_response increment_1

        increment_2 = default_sdk.payments.increment_payment_authorization(payment_response.id,
                                                                                  request,
                                                                                  idempotency_key)

        assert_response increment_2
        expect(increment_1.action_id).to eq(increment_2.action_id)
      end
    end
  end
end

def make_authorization_payment
  identification = CheckoutSdk::Common::AccountHolderIdentification.new
  identification.type = CheckoutSdk::Common::AccountHolderIdentificationType::NATIONAL_ID
  identification.number = '1234'
  identification.issuing_country = CheckoutSdk::Common::Country::GT

  sender = CheckoutSdk::Payments::IndividualSender.new
  sender.first_name = Helpers::DataFactory::FIRST_NAME
  sender.first_name = Helpers::DataFactory::LAST_NAME
  sender.address = address
  sender.identification = identification

  request = CheckoutSdk::Payments::PaymentRequest.new
  request.source = card_source
  request.reference = SecureRandom.uuid
  request.amount = 10
  request.currency = CheckoutSdk::Common::Currency::USD
  request.capture = false
  request.customer = common_customer_request
  request.sender = sender
  request.authorization_type = CheckoutSdk::Payments::AuthorizationType::ESTIMATED

  response = default_sdk.payments.request_payment(request)
  assert_response(response, %w[id])
  response
end
