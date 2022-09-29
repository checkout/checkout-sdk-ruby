RSpec.describe CheckoutSdk do
  include PaymentsHelper

  context 'when fetching existing dispute' do
    it 'retrieves dispute details' do
      response = oauth_sdk.disputes.get_dispute_details('dsp_35c0fdfabe770k17440a')

      expect(response).not_to be nil
      expect(response.id).to eq 'dsp_35c0fdfabe770k17440a'
    end
  end

  context 'when requesting a payment with card source' do
    it 'creates a card payment request' do
      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = card_source
      request.reference = SecureRandom.uuid
      request.amount = 100
      request.currency = CheckoutSdk::Common::Currency::USD
      request.capture = false
      request.customer = common_customer_request
      request.sender = get_individual_sender(get_account_holder_identification)
      request.processing_channel_id = 'pc_a6dabcfa2o3ejghb3sjuotdzzy'
      request.amount_allocations = [get_amount_allocations(id: 'ent_ocw5i74vowfg2edpy66izhts2u',
                                                           amount: 100)]

      response = oauth_sdk.payments.request_payment(request)

      expect(response).not_to be nil
      expect(response.id).not_to be nil

      payment_details = oauth_sdk.payments.get_payment_details 'pay_ylgcsw375dlerpee2zyfetdah4'
      expect(payment_details).not_to be nil
      expect(payment_details.id).not_to be nil

    end
  end

end
