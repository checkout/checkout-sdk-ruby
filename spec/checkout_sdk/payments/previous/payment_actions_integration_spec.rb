RSpec.describe CheckoutSdk::Previous::Payments do
  include Previous::PaymentsHelper

  before(:all) do
    @api = previous_sdk
  end

  describe '.get_payment_actions', skip: 'unavailable' do
    context 'when make a payment' do
      it 'get payment actions' do
        payment_response = make_card_payment(capture: true)

        proc = -> { @api.payments.get_payment_actions(payment_response.id) }
        predicate = ->(response) { there_are_two_payment_actions(response) }

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
