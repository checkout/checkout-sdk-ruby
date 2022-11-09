RSpec.describe CheckoutSdk::Balances do

  describe '.retrieve_entity_balances' do
    context 'when requesting balances for a entity' do
      it 'successfully retrieve entity balances' do
        query = "currency=#{CheckoutSdk::Common::Currency::GBP}"
        response = oauth_sdk.balances.retrieve_entity_balances('ent_kidtcgc3ge5unf4a5i6enhnr5m', query)

        expect(response).not_to be_nil
        response.data&.each do |balance|
          expect(balance.descriptor).not_to be_nil
          expect(balance.holding_currency).not_to be_nil
          expect(balance.balances).not_to be_nil
        end
      end
    end
  end
end
