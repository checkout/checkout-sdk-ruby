# frozen_string_literal: true

module CheckoutSdk
  module Apm
    class IdealClient < Client
      IDEAL_EXTERNAL = 'ideal-external'
      ISSUERS = 'issuers'
      private_constant :IDEAL_EXTERNAL, :ISSUERS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
      end

      def info
        api_client.invoke_get(IDEAL_EXTERNAL, sdk_authorization)
      end

      def issuers
        api_client.invoke_get(build_path(IDEAL_EXTERNAL, ISSUERS), sdk_authorization)
      end
    end
  end
end
