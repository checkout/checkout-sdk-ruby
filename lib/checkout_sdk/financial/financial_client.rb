# frozen_string_literal: true

module CheckoutSdk
  module Financial
    class FinancialClient < Client
      FINANCIAL_ACTIONS = 'financial-actions'
      private_constant :FINANCIAL_ACTIONS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH
      end

      # @param [FinancialActionsQuery] query_filter
      def query(query_filter)
        api_client.invoke_get(FINANCIAL_ACTIONS, sdk_authorization, query_filter)
      end
    end
  end
end
