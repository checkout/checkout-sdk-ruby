# frozen_string_literal: true

module ContextsHelper

  def create_payment_contexts
    request = {
      'source' => {
        'type' => 'paypal'
      },
      'amount' => 2000,
      'currency' => CheckoutSdk::Common::Currency::EUR,
      'payment_type' => CheckoutSdk::Payments::PaymentType::REGULAR,
      'capture' => true,
      'processing_channel_id' => ENV.fetch('CHECKOUT_PROCESSING_CHANNEL_ID', nil),
      'success_url' => 'https://example.com/payments/success',
      'failure_url' => 'https://example.com/payments/fail',
      'items' => [
        {
          'name' => 'mask',
          'unit_price' => 2000,
          'quantity' => 1
        }
      ]
    }

    response = default_sdk.contexts.create_payment_contexts(request)
    expect(response).not_to be nil
    expect(response.id).not_to be nil
    response
  end

end
