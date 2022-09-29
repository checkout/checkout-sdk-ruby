RSpec.describe CheckoutSdk::Forex do

  describe '.request_quote' do
    context 'when requesting a quote with valid parameters' do
      it 'retrieves valid quotes' do
        request = CheckoutSdk::Forex::QuoteRequest.new
        request.source_currency = CheckoutSdk::Common::Currency::GBP
        request.source_amount = 30000
        request.destination_currency = CheckoutSdk::Common::Currency::USD
        request.process_channel_id = 'pc_abcdefghijklmnopqrstuvwxyz'

        response = oauth_sdk.forex.request_quote(request)

        assert_response response, %w[destination_amount
                                     rate
                                     expires_on]
        expect(response.source_currency).to eq request.source_currency
        expect(response.source_amount).to eq request.source_amount
        expect(response.destination_currency).to eq request.destination_currency
      end
    end
  end
end
