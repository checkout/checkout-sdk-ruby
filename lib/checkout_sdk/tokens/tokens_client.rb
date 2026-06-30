# frozen_string_literal: true

module CheckoutSdk
  module Tokens
    class TokensClient < Client
      TOKENS = 'tokens'
      private_constant :TOKENS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::PUBLIC_KEY)
      end

      # @param [Hash, CardTokenRequest, WalletTokenRequest] token_request
      def request_token(token_request)
        api_client.invoke_post(TOKENS, sdk_authorization, token_request)
      end

      # Returns the details for an active token without consuming it.
      # The token remains usable after this call.
      # Requires SecretKey or OAuth (not PublicKey).
      # @param [String] token_id Pattern: ^(tok)_(\w{26})$
      def get_token_metadata(token_id)
        api_client.invoke_get(
          build_path(TOKENS, token_id, 'metadata'),
          sdk_authorization(CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
        )
      end
    end
  end
end
