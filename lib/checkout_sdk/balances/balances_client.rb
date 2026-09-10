# frozen_string_literal: true

module CheckoutSdk
  module Balances
    class BalancesClient < Client
      BALANCES = 'balances'
      ENTITIES = 'entities'
      CURRENCY_ACCOUNTS = 'currency-accounts'
      TOP_UP_INSTRUCTIONS = 'top-up-instructions'
      private_constant :BALANCES, :ENTITIES, :CURRENCY_ACCOUNTS, :TOP_UP_INSTRUCTIONS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # Retrieves the balances for each sub-account belonging to an entity.
      #
      # @param [String] entity_id the ID of the entity
      # @param [String, BalancesQuery] balances_query a raw query string
      #   (e.g. "currency:GBP") or a {BalancesQuery}
      # @return [Hash] the balances response
      def retrieve_entity_balances(entity_id, balances_query)
        api_client.invoke_get(build_path(BALANCES, entity_id), sdk_authorization, balances_query)
      end

      # Retrieves the bank details required to top up a sub-account, along with the payment
      # reference that attributes an incoming payment to that sub-account.
      #
      # Note: The sub-account is referred to as currency account in the API.
      #
      # The response maps to {TopUpInstructions}, whose `bank_details` is a {TopUpBankDetails}
      # holding up to two {TopUpFundingDetails} rails. Neither rail is guaranteed.
      #
      # @param [String] entity_id the ID of the entity that owns the sub-account, or of an entity
      #   above it in your hierarchy; a platform can use its own entity ID to reach the
      #   sub-accounts of any entity beneath it
      # @param [String] currency_account_id the ID of the sub-account to retrieve top-up
      #   instructions for
      # @return [Hash] the top-up instructions response
      # @raise [CheckoutArgumentException] if either path parameter is nil, empty or blank. Both
      #   segments are interpolated straight into the request path, so a blank value would build a
      #   malformed URL and be rejected by the API rather than by the SDK.
      def retrieve_top_up_instructions(entity_id, currency_account_id)
        raise CheckoutArgumentException, 'entity_id cannot be blank' if entity_id.to_s.strip.empty?
        raise CheckoutArgumentException, 'currency_account_id cannot be blank' if currency_account_id.to_s.strip.empty?

        api_client.invoke_get(
          build_path(ENTITIES, entity_id, CURRENCY_ACCOUNTS, currency_account_id, TOP_UP_INSTRUCTIONS),
          sdk_authorization
        )
      end
    end
  end
end
