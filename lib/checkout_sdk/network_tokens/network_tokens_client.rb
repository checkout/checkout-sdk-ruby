# frozen_string_literal: true

module CheckoutSdk
  module NetworkTokens
    # Client for the Network Tokens API.
    class NetworkTokensClient < Client
      NETWORK_TOKENS = 'network-tokens'
      CRYPTOGRAMS = 'cryptograms'
      DELETE = 'delete'
      private_constant :NETWORK_TOKENS, :CRYPTOGRAMS, :DELETE

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # Provision a Network Token.
      # @param [Hash, ProvisionNetworkTokenRequest] provision_request
      def provision_network_token(provision_request)
        api_client.invoke_post(NETWORK_TOKENS, sdk_authorization, provision_request)
      end

      # Retrieve a Network Token.
      # @param [String] network_token_id
      def get_network_token(network_token_id)
        api_client.invoke_get(build_path(NETWORK_TOKENS, network_token_id), sdk_authorization)
      end

      # Request a fresh cryptogram for a Network Token (for SCA / fresh payment flows).
      # @param [String] network_token_id
      # @param [Hash, NetworkTokenCryptogramRequest] cryptogram_request
      def request_cryptograms(network_token_id, cryptogram_request = nil)
        api_client.invoke_post(
          build_path(NETWORK_TOKENS, network_token_id, CRYPTOGRAMS),
          sdk_authorization,
          cryptogram_request
        )
      end

      # Soft-delete a Network Token. The API uses PATCH on .../delete.
      # @param [String] network_token_id
      def delete_network_token(network_token_id)
        api_client.invoke_patch(
          build_path(NETWORK_TOKENS, network_token_id, DELETE),
          sdk_authorization
        )
      end
    end
  end
end
