RSpec.describe CheckoutSdk::Previous::Payments do

  before(:all) do
    @api = previous_sdk
  end

  describe '.request_payout', skip: 'unavailable' do
    context 'when attempt payout' do
      it 'successfully make a payout' do

        destination = CheckoutSdk::Previous::Payments::CardDestination.new
        destination.number = visa_card.card_number
        destination.first_name = Helpers::DataFactory::FIRST_NAME
        destination.last_name = Helpers::DataFactory::LAST_NAME
        destination.expiry_month = visa_card.expiry_month
        destination.expiry_year = visa_card.expiry_year
        destination.name = visa_card.name
        destination.billing_address = address
        destination.phone = phone

        request = CheckoutSdk::Previous::Payments::PayoutRequest.new
        request.destination = destination
        request.capture = false
        request.reference = SecureRandom.uuid
        request.amount = 5
        request.currency = CheckoutSdk::Common::Currency::GBP

        response = @api.payments.request_payout(request)
        assert_response(response, %w[id
                                     reference
                                     status
                                     customer
                                     customer.id])
      end
    end
  end
end
