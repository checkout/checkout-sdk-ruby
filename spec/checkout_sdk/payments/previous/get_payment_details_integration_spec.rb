RSpec.describe CheckoutSdk::Previous::Payments do
  include Previous::PaymentsHelper

  before(:all) do
    @api = previous_sdk
  end

  describe '.get_payment_details', skip: 'unavailable' do
    context 'when make a payment' do
      it 'returns payment details' do
        payment_response = make_card_payment

        response = @api.payments.get_payment_details(payment_response.id)
        assert_response(response, %w[id
                                     requested_on
                                     amount
                                     currency
                                     payment_type
                                     reference
                                     status
                                     approved
                                     scheme_id
                                     source.id
                                     source.type
                                     source.fingerprint
                                     source.card_type
                                     customer.id
                                     customer.name])

      end
    end
  end
end
