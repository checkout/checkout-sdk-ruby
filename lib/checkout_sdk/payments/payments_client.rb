# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class PaymentsClient < BasePaymentsClient
      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH
      end

      # @param [PaymentRequest] payment_request
      # @param [String, nil] idempotency_key
      def request_payment(payment_request, idempotency_key = nil)
        api_client.invoke_post(PAYMENTS_PATH,
                               sdk_authorization,
                               payment_request,
                               idempotency_key)
      end

      # @param [PayoutRequest] payout_request
      # @param [String, nil] idempotency_key
      def request_payout(payout_request, idempotency_key = nil)
        api_client.invoke_post(PAYMENTS_PATH,
                               sdk_authorization,
                               payout_request,
                               idempotency_key)
      end

      # @param [String] payment_id
      # @param [CaptureRequest] capture_request
      # @param [String, nil] idempotency_key
      def capture_payment(payment_id, capture_request = nil, idempotency_key = nil)
        api_client.invoke_post(build_path(PAYMENTS_PATH, payment_id, 'captures'),
                               sdk_authorization,
                               capture_request,
                               idempotency_key)
      end

      # @param [String] payment_id
      # @param [AuthorizationRequest] authorization_request
      # @param [String, nil] idempotency_key
      def increment_payment_authorization(payment_id, authorization_request = nil, idempotency_key = nil)
        api_client.invoke_post(build_path(PAYMENTS_PATH, payment_id, 'authorizations'),
                               sdk_authorization,
                               authorization_request,
                               idempotency_key)
      end
    end
  end
end
