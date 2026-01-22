# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class PaymentContextsClient < Client
      PAYMENT_CONTEXTS = 'payment-contexts'

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # @param [Hash] payment_contexts
      def create_payment_contexts(payment_contexts)
        api_client.invoke_post(PAYMENT_CONTEXTS, sdk_authorization, payment_contexts)
      end

      # @param [String] payment_context_id
      def get_payment_context_details(payment_context_id)
        api_client.invoke_get(build_path(PAYMENT_CONTEXTS, payment_context_id), sdk_authorization)
      end
    end
  end
end
