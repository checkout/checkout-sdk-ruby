# frozen_string_literal: true

module CheckoutSdk
  module Balances
    class BalancesClient < Client
      BALANCES = 'balances'
      private_constant :BALANCES

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # @param [String] entity_id
      # @param [String] balances_query
      def retrieve_entity_balances(entity_id, balances_query)
        api_client.invoke_get(build_path(BALANCES, entity_id), sdk_authorization, balances_query)
      end
    end
  end
end
