RSpec.describe CheckoutSdk::Forex do

  skip 'Skipping because processing_channel_id is invalid' do
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

  skip 'Skipping because processing_channel_id is invalid' do
    describe '.get_rates' do
      context 'when fetching rates with valid parameters' do
        it 'retrieves valid rates' do
          query = CheckoutSdk::Forex::RatesQueryFilter.new
          query.product = 'card_payouts'
          query.source = CheckoutSdk::Forex::ForexSource::VISA
          query.currency_pairs = 'GBPEUR,USDNOK,JPNCAD'
          query.process_channel_id = 'pc_abcdefghijklmnopqrstuvwxyz'

          response = oauth_sdk.forex.get_rates(query)

          assert_response response, %w[product
                                       source
                                       rates]
          expect(response.product).to eq query.product
          expect(response.source).to eq query.source
        end
      end
    end
  end
end
