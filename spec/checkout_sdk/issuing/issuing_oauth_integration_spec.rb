RSpec.describe CheckoutSdk::Issuing do
  skip 'Requires sandbox OAuth credentials with the Issuing scope and a provisioned cardholder + card' do
    let(:client) { oauth_sdk.issuing }

    describe '#request_cardholder_access_token' do
      it 'returns a cardholder access token' do
        request = CheckoutSdk::Issuing::CardholderAccessTokenRequest.new
        request.client_id = ENV['CHECKOUT_OAUTH_CLIENT_ID']
        request.client_secret = ENV['CHECKOUT_OAUTH_CLIENT_SECRET']
        request.cardholder_id = ENV['CHECKOUT_CARDHOLDER_ID']
        request.single_use = true
        response = client.request_cardholder_access_token(request)
        expect(response).not_to be_nil
      end
    end

    describe '#simulate_oob_authentication' do
      it 'simulates an OOB authentication' do
        request = CheckoutSdk::Issuing::OobAuthenticationRequest.new
        request.card_id = ENV['CHECKOUT_ISSUING_CARD_ID']
        request.transaction_details = CheckoutSdk::Issuing::OobSimulateTransactionDetails.new
        request.transaction_details.merchant_name = 'Acme Ltd'
        request.transaction_details.purchase_amount = 100
        request.transaction_details.purchase_currency = 'GBP'
        response = client.simulate_oob_authentication(request)
        expect(response).not_to be_nil
      end
    end
  end
end
