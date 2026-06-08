# frozen_string_literal: true

module CheckoutSdk
  module StandaloneAccountUpdater
    # Client for the Standalone Account Updater API.
    # Uses OAuth with the `vault:real-time-account-updater` scope.
    class StandaloneAccountUpdaterClient < Client
      ACCOUNT_UPDATER = 'account-updater'
      CARDS = 'cards'
      private_constant :ACCOUNT_UPDATER, :CARDS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::OAUTH)
      end

      # Get updated card credentials.
      # @param [Hash, AccountUpdaterRequest] account_updater_request
      def update_card(account_updater_request)
        api_client.invoke_post(
          build_path(ACCOUNT_UPDATER, CARDS),
          sdk_authorization,
          account_updater_request
        )
      end
    end
  end
end
