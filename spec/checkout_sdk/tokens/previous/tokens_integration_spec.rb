RSpec.describe CheckoutSdk::Tokens do

  describe '.request_card_token', skip: 'unavailable' do
    context "when requesting a token with correct data" do
      it 'returns a valid card token' do
        request = CheckoutSdk::Tokens::CardTokenRequest.new
        request.number = visa_card.card_number
        request.expiry_month = visa_card.expiry_month
        request.expiry_year = visa_card.expiry_year

        response = previous_sdk.tokens.request_token(request)

        expect(default_sdk).not_to be nil
        expect(response).not_to be nil
        expect(response.token).not_to be nil
      end
    end
  end

end
