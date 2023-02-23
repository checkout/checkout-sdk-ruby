# frozen_string_literal: true

module CheckoutSdk
  module Transfers
    class TransfersClient < Client
      TRANSFERS = 'transfers'
      private_constant :TRANSFERS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # @param [Hash, CreateTransfer] create_transfer
      # @param [String, nil] idempotency_key
      def initiate_transfer_of_funds(create_transfer, idempotency_key = nil)
        api_client.invoke_post(TRANSFERS, sdk_authorization, create_transfer, idempotency_key)
      end

      # @param [String] transfer_id
      def retrieve_transfer(transfer_id)
        api_client.invoke_get(build_path(TRANSFERS, transfer_id), sdk_authorization)
      end
    end
  end
end
