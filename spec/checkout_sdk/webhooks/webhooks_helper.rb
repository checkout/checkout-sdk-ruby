# frozen_string_literal: true

module WebhooksHelper

  GATEWAY_EVENT_TYPES = %w[payment_approved
                           payment_canceled
                           payment_capture_declined
                           payment_capture_pending
                           payment_captured
                           payment_chargeback
                           payment_declined
                           payment_expired
                           payment_paid
                           payment_pending
                           payment_refund_declined
                           payment_refund_pending
                           payment_refunded
                           payment_retrieval
                           payment_void_declined
                           payment_voided].freeze

  def register_webhook(url)
    request = CheckoutSdk::Previous::Webhooks::WebhookRequest.new
    request.url = url
    request.event_types = GATEWAY_EVENT_TYPES

    previous_sdk.webhooks.register_webhook request
  end

  def delete_webhook(webhook_id)

    previous_sdk.webhooks.remove_webhook webhook_id
  rescue CheckoutSdk::CheckoutApiException => e
    # Ignore might be already deleted
  end
end
