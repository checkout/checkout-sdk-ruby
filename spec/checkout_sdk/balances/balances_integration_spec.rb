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

  describe '.retrieve_top_up_instructions' do
    # GET /entities/{entityId}/currency-accounts/{currencyAccountId}/top-up-instructions
    #
    # Top-ups are not enabled on the sandbox sub-accounts this suite has access to, so the
    # endpoint answers 403 ("top-ups aren't enabled for the sub-account") rather than 200.
    # Verified live on 2026-09-08 with the balances:top-up-instructions scope granted.
    #
    # The example accepts either outcome, but only the outcomes the spec documents as "not
    # available here": 403 and 404. It still fails on 400 (malformed identifiers, i.e. the SDK
    # built the path wrongly) and on 401 (wrong authorization type).
    context 'when requesting top-up instructions for a sub-account' do
      it 'returns the instructions, or a documented not-available status' do
        entity_id = 'ent_kidtcgc3ge5unf4a5i6enhnr5m'

        query = CheckoutSdk::Balances::BalancesQuery.new
        query.with_currency_account_id = true
        balances = oauth_sdk.balances.retrieve_entity_balances(entity_id, query)

        # Take the first sub-account that reports an id. Requiring the entity to always have one
        # would fail this example for a reason unrelated to top-up instructions.
        accounts = balances.data || []
        currency_account_id = accounts.map(&:currency_account_id).compact.first
        skip 'no sub-account reported a currency_account_id' if currency_account_id.nil?

        begin
          response = oauth_sdk.balances.retrieve_top_up_instructions(entity_id, currency_account_id)

          expect(response).not_to be_nil
          expect(response.currency_account_id).to eq(currency_account_id)
          expect(response.currency).not_to be_nil
          expect(response.payment_reference).not_to be_nil
          expect(response.bank_details).not_to be_nil

          # Assert only what the spec guarantees: bank_details declares no required properties,
          # so an empty object is a legal 200 body. Where a rail IS returned, its two required
          # fields must be present.
          [response.bank_details.domestic, response.bank_details.international].compact.each do |rail|
            expect(rail.beneficiary_account_name).not_to be_nil
            expect(rail.bank_name).not_to be_nil
          end
        rescue CheckoutSdk::CheckoutApiException => e
          expect([403, 404]).to include(e.http_metadata.status_code)
        end
      end
    end
  end
end
