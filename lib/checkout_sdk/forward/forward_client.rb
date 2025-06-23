# frozen_string_literal: true

module CheckoutSdk
  module Forward
    class ForwardClient < Client
      FORWARD = 'forward'
      private_constant :FORWARD

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
    end
  end
end
