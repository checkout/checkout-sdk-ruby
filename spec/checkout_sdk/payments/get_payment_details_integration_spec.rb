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

  describe '.get_payment_details' do
    context 'make 3ds card payment n3d' do
      it 'returns payment details' do
        payment_response = make_3ds_card_payment(attempt_n3d: true)

        response = @api.payments.get_payment_details(payment_response.id)
        assert_response(response, %w[id
                                     requested_on
                                     source.id
                                     source.type
                                     source.fingerprint
                                     source.card_type
                                     amount
                                     currency
                                     payment_type
                                     reference
                                     status
                                     approved
                                     scheme_id
                                     customer.id
                                     customer.name
                                     sender.address.city
                                     3ds.downgraded
                                     3ds.cryptogram
                                     3ds.xid
                                     3ds.version])

      end
    end
  end
end
