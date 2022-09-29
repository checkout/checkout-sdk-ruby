# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class PaymentsClient < Client
      PAYMENTS_PATH = 'payments'
      private_constant :PAYMENTS_PATH

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
      def get_payment_details(payment_id)
        api_client.invoke_get(build_path(PAYMENTS_PATH, payment_id),
                              sdk_authorization)
      end

      # @param [String] payment_id
      def get_payment_actions(payment_id)
        api_client.invoke_get(build_path(PAYMENTS_PATH, payment_id, 'actions'),
                              sdk_authorization)
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
      # @param [RefundRequest] refund_request
      # @param [String, nil] idempotency_key
      def refund_payment(payment_id, refund_request = nil, idempotency_key = nil)
        api_client.invoke_post(build_path(PAYMENTS_PATH, payment_id, 'refunds'),
                               sdk_authorization,
                               refund_request,
                               idempotency_key)
      end

      # @param [String] payment_id
      # @param [VoidRequest] void_request
      # @param [String, nil] idempotency_key
      def void_payment(payment_id, void_request = nil, idempotency_key = nil)
        api_client.invoke_post(build_path(PAYMENTS_PATH, payment_id, 'voids'),
                               sdk_authorization,
                               void_request,
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
