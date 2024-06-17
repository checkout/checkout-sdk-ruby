# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class BasePaymentsClient < Client
      PAYMENTS_PATH = 'payments'

      # @param [Hash, PaymentsQueryFilter] query_filter
      def get_payments_list(query_filter)
        api_client.invoke_get(PAYMENTS_PATH, sdk_authorization, query_filter)
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
      # @param [Hash, RefundRequest] refund_request
      # @param [String, nil] idempotency_key
      def refund_payment(payment_id, refund_request = nil, idempotency_key = nil)
        api_client.invoke_post(build_path(PAYMENTS_PATH, payment_id, 'refunds'),
                               sdk_authorization,
                               refund_request,
                               idempotency_key)
      end

      # @param [String] payment_id
      # @param [Hash, VoidRequest] void_request
      # @param [String, nil] idempotency_key
      def void_payment(payment_id, void_request = nil, idempotency_key = nil)
        api_client.invoke_post(build_path(PAYMENTS_PATH, payment_id, 'voids'),
                               sdk_authorization,
                               void_request,
                               idempotency_key)
      end

      # @param [String] payment_id
      # @param [Hash, ReverseRequest] reverse_request
      # @param [String, nil] idempotency_key
      def reverse_payment(payment_id, reverse_request = nil, idempotency_key = nil)
        api_client.invoke_post(build_path(PAYMENTS_PATH, payment_id, 'reversals'),
                               sdk_authorization,
                               reverse_request,
                               idempotency_key)
      end
    end
  end
end
