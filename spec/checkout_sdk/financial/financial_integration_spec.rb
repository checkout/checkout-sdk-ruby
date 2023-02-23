# frozen_string_literal: true

RSpec.describe CheckoutSdk::Financial do
  include PaymentsHelper

  describe '.query' do
    context 'when querying with valid filters' do
      skip 'returns valid financial actions' do
        payment = make_card_payment(amount: 100, capture: true)

        query = CheckoutSdk::Financial::FinancialActionsQuery.new
        query.limit = 5
        query.payment_id = payment.id

        proc = -> { oauth_sdk.financial.query(query) }
        predicate = ->(response) { there_are_financial_actions response }

        response = retriable proc, predicate, 5

        assert_response response,
                        %w[http_metadata
                           count
                           data
                           _links]

        response.data&.each do |action|
          assert_response action,
                          %w[payment_id
                             action_id
                             action_type
                             entity_id
                             currency_account_id
                             processed_on
                             requested_on]
        end
      end

      context 'when querying with invalid filters' do
        it 'raises an error' do
          query = CheckoutSdk::Financial::FinancialActionsQuery.new
          query.limit = 300

          expect { oauth_sdk.financial.query(query) }.to raise_error(CheckoutSdk::CheckoutApiException)
        end
      end
    end
  end
end

private def there_are_financial_actions(response)
  response.count > 0
end

