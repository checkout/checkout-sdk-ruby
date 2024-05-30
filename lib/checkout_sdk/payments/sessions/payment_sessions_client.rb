# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class PaymentSessionsClient < Client
      PAYMENT_SESSIONS = 'payment-sessions'

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY
      end

      # @param [Hash, PaymentSessionsRequest] payment_sessions
      def create_payment_sessions(payment_sessions)
        api_client.invoke_post(PAYMENT_SESSIONS, sdk_authorization, payment_sessions)
      end
    end
  end
end
