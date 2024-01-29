# frozen_string_literal: true

module PaymentSessionsHelper

  def create_payment_sessions
    request = {
      'amount' => 2000,
      'currency' => CheckoutSdk::Common::Currency::GBP,
      'reference' => 'ORD-123A',
      'billing' => {
        'address' => {
          'country' => CheckoutSdk::Common::Country::GB
        }
      },
      'customer' => {
        'name' => 'John Smith',
        'email' => 'john.smith@example.com',
      },
      'success_url' => 'https://example.com/payments/success',
      'failure_url' => 'https://example.com/payments/fail'
    }

    response = default_sdk.payment_sessions.create_payment_sessions(request)
    expect(response).not_to be nil

    response
  end

end
