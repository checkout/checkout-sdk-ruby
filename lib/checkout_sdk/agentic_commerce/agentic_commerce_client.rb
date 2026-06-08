# frozen_string_literal: true

module CheckoutSdk
  module AgenticCommerce
    # Client for the Agentic Commerce Protocol API (Beta).
    # Used by AI agents to create delegated payment tokens scoped to a single purchase.
    class AgenticCommerceClient < Client
      AGENTIC_COMMERCE = 'agentic_commerce'
      DELEGATE_PAYMENT = 'delegate_payment'
      private_constant :AGENTIC_COMMERCE, :DELEGATE_PAYMENT

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
      end

      # Create a delegated payment token.
      # @param [Hash, DelegatedPaymentRequest] delegated_payment_request
      # @param [String] idempotency_key Optional
      def create_delegated_payment_token(delegated_payment_request, idempotency_key = nil)
        api_client.invoke_post(
          build_path(AGENTIC_COMMERCE, DELEGATE_PAYMENT),
          sdk_authorization,
          delegated_payment_request,
          idempotency_key
        )
      end
    end
  end
end
