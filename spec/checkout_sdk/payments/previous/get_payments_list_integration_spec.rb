RSpec.describe CheckoutSdk::Payments do
  include PaymentsHelper

  describe 'Previous' do
    describe '.get_payments_list' do
      context 'when querying with valid reference' do
        it 'returns valid payment' do
          payment_response = make_card_payment

          query = CheckoutSdk::Payments::PaymentsQueryFilter.new
          query.limit = 100
          query.skip = 0
          query.reference = payment_response.reference

          proc = -> { default_sdk.payments.get_payments_list(query) }
          predicate = ->(response) { there_are_payments response }

          response = retriable proc, predicate

          assert_response response, %w[limit
                                     skip
                                     total_count
                                     data]

          expect(response.total_count).to be > 0
          expect(response.data[0].reference).to eq payment_response.reference
        end
      end
    end
  end
end

private def there_are_payments(response)
  sleep 10
  response.total_count > 0
end
