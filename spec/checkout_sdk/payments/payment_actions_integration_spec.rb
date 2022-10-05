RSpec.describe CheckoutSdk::Payments do
  include PaymentsHelper

  describe '.get_payment_actions' do
    context 'when make a payment' do
      it 'get payment actions' do
        payment_response = make_card_payment(capture:true)

        proc = lambda { default_sdk.payments.get_payment_actions(payment_response.id) }
        predicate = lambda { |response| there_are_two_payment_actions(response) }

        response = retriable(proc, predicate)
        assert_response response
        expect(response.items.length).to eq(2)
      end
    end
  end
end

def there_are_two_payment_actions(response)
  response.items.length == 2
end
