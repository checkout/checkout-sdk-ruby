# frozen_string_literal: true

module CheckoutSdk
  module Forward
    class ForwardClient < Client
      FORWARD = 'forward'
      SECRETS = 'secrets'
      private_constant :FORWARD, :SECRETS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # @param [Hash] forward_request
      def forward_request(forward_request)
        api_client.invoke_post(build_path(FORWARD), sdk_authorization, forward_request)
      end

      # @param [String] forward_id
      def get(forward_id)
        api_client.invoke_get(build_path(FORWARD, forward_id), sdk_authorization)
      end

      # @param [Hash, CreateSecretRequest] create_secret_request
      def create_secret(create_secret_request)
        api_client.invoke_post(build_path(FORWARD, SECRETS),
                               sdk_authorization,
                               create_secret_request)
      end

      def get_secrets
        api_client.invoke_get(build_path(FORWARD, SECRETS), sdk_authorization)
      end

      # @param [String] name
      # @param [Hash, UpdateSecretRequest] update_secret_request
      def update_secret(name, update_secret_request)
        api_client.invoke_patch(build_path(FORWARD, SECRETS, name),
                                sdk_authorization,
                                update_secret_request)
      end

      # @param [String] name
      def delete_secret(name)
        api_client.invoke_delete(build_path(FORWARD, SECRETS, name),
                                 sdk_authorization)
      end
    end
  end
end
