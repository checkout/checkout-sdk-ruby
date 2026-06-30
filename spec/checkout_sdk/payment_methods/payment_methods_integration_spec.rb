RSpec.describe CheckoutSdk::PaymentMethods do
  skip 'Requires a sandbox processing channel configured with payment methods' do
    let(:client) { default_sdk.payment_methods }

    describe '#get_payment_methods' do
      it 'returns the payment methods configured for the channel' do
        query = CheckoutSdk::PaymentMethods::PaymentMethodsQuery.new
        query.processing_channel_id = ENV['CHECKOUT_PROCESSING_CHANNEL_ID']
        response = client.get_payment_methods(query)
        expect(response).not_to be_nil
      end
    end
  end
end
