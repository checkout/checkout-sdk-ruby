# frozen_string_literal: true

module CheckoutSdk
  module Metadata
    class MetadataClient < Client
      METADATA = 'metadata'
      CARD = 'card'
      private_constant :METADATA, :CARD

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH
      end

      # @param [MetadataRequest] metadata_request
      def request_card_metadata(metadata_request)
        api_client.invoke_post(build_path(METADATA, CARD), sdk_authorization, metadata_request)
      end
    end
  end
end
