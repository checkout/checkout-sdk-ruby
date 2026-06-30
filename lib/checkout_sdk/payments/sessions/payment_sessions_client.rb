# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class PaymentSessionsClient < Client
      PAYMENT_SESSIONS = 'payment-sessions'
      COMPLETE = 'complete'
      private_constant :COMPLETE

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
      end

      # @param [Hash, PaymentSessionsRequest] payment_sessions
      def create_payment_sessions(payment_sessions)
        api_client.invoke_post(PAYMENT_SESSIONS, sdk_authorization, payment_sessions)
      end

      # Create and immediately submit a payment session. POST /payment-sessions/complete.
      # @param [Hash] payment_sessions_request
      def create_and_complete_payment_sessions(payment_sessions_request)
        api_client.invoke_post(
          build_path(PAYMENT_SESSIONS, COMPLETE),
          sdk_authorization,
          payment_sessions_request
        )
      end
    end
  end
end
