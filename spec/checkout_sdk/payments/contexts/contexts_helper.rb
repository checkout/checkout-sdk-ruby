# frozen_string_literal: true

module ContextsHelper

  def create_payment_contexts_paypal
    request = {
      'source' => {
        'type' => 'paypal'
      },
      'amount' => 1000,
      'currency' => CheckoutSdk::Common::Currency::EUR,
      'payment_type' => CheckoutSdk::Payments::PaymentType::REGULAR,
      'capture' => true,
      'processing_channel_id' => ENV.fetch('CHECKOUT_PROCESSING_CHANNEL_ID', nil),
      'success_url' => 'https://example.com/payments/success',
      'failure_url' => 'https://example.com/payments/fail',
      'items' => [
        {
          'name' => 'mask',
          'unit_price' => 1000,
          'quantity' => 1,
          'total_amount' => 1000
        }
      ]
    }

    response = default_sdk.contexts.create_payment_contexts(request)
    expect(response).not_to be nil
    expect(response.id).not_to be nil
    expect(response.partner_metadata.order_id).not_to be nil
    response
  end

  def create_payment_contexts_klarna
    request = {
      'source' => {
        'type' => 'klarna',
        'account_holder' => {
          'billing_address' => {
            'country' => 'DE'
          }
        }
      },
      'amount' => 1000,
      'currency' => CheckoutSdk::Common::Currency::EUR,
      'payment_type' => CheckoutSdk::Payments::PaymentType::REGULAR,
      'processing_channel_id' => ENV.fetch('CHECKOUT_PROCESSING_CHANNEL_ID', nil),
      'items' => [
        {
          'name' => 'mask',
          'unit_price' => 1000,
          'quantity' => 1,
          'total_amount' => 1000,
          'reference' => 'BA67A'
        }
      ],
      'processing' => {
        'locale' => 'en-GB'
      }
    }

    response = default_sdk.contexts.create_payment_contexts(request)
    expect(response).not_to be nil
    expect(response.id).not_to be nil
    expect(response.partner_metadata.client_token).not_to be nil
    expect(response.partner_metadata.session_id).not_to be nil
    response
  end

end
