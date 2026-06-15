RSpec.describe CheckoutSdk::NetworkTokens do
  skip 'Requires a sandbox account configured for Network Tokens' do
    let(:client) { default_sdk.network_tokens }

    describe '#provision_network_token' do
      it 'provisions a network token from raw card details' do
        request = CheckoutSdk::NetworkTokens::ProvisionNetworkTokenRequest.new
        source = CheckoutSdk::NetworkTokens::NetworkTokenSourceCard.new
        source.number = Helpers::DataFactory::CARD_NUMBER
        source.cvv = Helpers::DataFactory::CVV
        source.expiry_month = Helpers::DataFactory::EXPIRY_MONTH.to_s
        source.expiry_year = Helpers::DataFactory::EXPIRY_YEAR.to_s
        request.source = source
        response = client.provision_network_token(request)
        expect(response).not_to be_nil
      end
    end

    describe '#get_network_token' do
      it 'retrieves a network token' do
        response = client.get_network_token(ENV['CHECKOUT_NETWORK_TOKEN_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#request_cryptograms' do
      it 'returns a fresh cryptogram for the network token' do
        request = CheckoutSdk::NetworkTokens::NetworkTokenCryptogramRequest.new
        request.transaction_type = 'ecom'
        response = client.request_cryptograms(ENV['CHECKOUT_NETWORK_TOKEN_ID'], request)
        expect(response).not_to be_nil
      end
    end

    describe '#delete_network_token' do
      it 'soft-deletes a network token' do
        response = client.delete_network_token(ENV['CHECKOUT_NETWORK_TOKEN_ID'])
        expect(response).not_to be_nil
      end
    end
  end
end
