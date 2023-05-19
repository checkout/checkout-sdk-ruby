# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    class IssuingClient < Client
      ISSUING = 'issuing'
      CARDHOLDERS = 'cardholders'
      CARDS = 'cards'
      private_constant :ISSUING, :CARDHOLDERS, :CARDS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH
      end

      # @param [Hash] cardholder_request
      def create_cardholder(cardholder_request)
        api_client.invoke_post(build_path(ISSUING, CARDHOLDERS), sdk_authorization, cardholder_request)
      end

      # @param [String] cardholder_id
      def get_cardholder(cardholder_id)
        api_client.invoke_get(build_path(ISSUING, CARDHOLDERS, cardholder_id), sdk_authorization)
      end

      # @param [String] cardholder_id
      def get_cardholder_cards(cardholder_id)
        api_client.invoke_get(build_path(ISSUING, CARDHOLDERS, cardholder_id, CARDS), sdk_authorization)
      end
    end
  end
end
