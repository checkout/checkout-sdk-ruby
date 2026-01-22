# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Sources
      class SourcesClient < Client
        SOURCES = 'sources'
        private_constant :SOURCES

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
        end

        # @param [Hash, SepaSourceRequest] sepa_source_request
        def create_sepa_source(sepa_source_request)
          api_client.invoke_post(SOURCES, sdk_authorization, sepa_source_request)
        end
      end
    end
  end
end
