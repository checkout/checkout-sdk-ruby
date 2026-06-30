# frozen_string_literal: true

module CheckoutSdk
  module PaymentMethods
    # Client for the Payment Methods configuration API.
    # GET /payment-methods returns the configured payment methods for a processing channel.
    class PaymentMethodsClient < Client
      PAYMENT_METHODS = 'payment-methods'
      private_constant :PAYMENT_METHODS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # Get available payment methods.
      # @param [Hash, PaymentMethodsQuery] payment_methods_query
      def get_payment_methods(payment_methods_query)
        api_client.invoke_get(PAYMENT_METHODS, sdk_authorization, payment_methods_query)
      end
    end
  end
end
