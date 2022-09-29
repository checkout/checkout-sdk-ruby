RSpec.describe CheckoutSdk::Payments do
  include PaymentsHelper

  before(:all) do
    @api = default_sdk
  end

  describe '.get_payment_details' do
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
                                     customer.name
                                     sender.address.city])

      end
    end
  end
end
