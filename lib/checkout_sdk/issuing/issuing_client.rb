# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    class IssuingClient < Client
      ISSUING = 'issuing'
      CARDHOLDERS = 'cardholders'
      CARDS = 'cards'
      THREE_DS = '3ds-enrollment'
      ACTIVATE = 'activate'
      CREDENTIALS = 'credentials'
      REVOKE = 'revoke'
      SUSPEND = 'suspend'
      CONTROLS = 'controls'
      private_constant :ISSUING,
                       :CARDHOLDERS,
                       :CARDS,
                       :THREE_DS,
                       :ACTIVATE,
                       :CREDENTIALS,
                       :REVOKE,
                       :SUSPEND,
                       :CONTROLS

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

      # @param [Hash] card_request
      def create_card(card_request)
        api_client.invoke_post(build_path(ISSUING, CARDS), sdk_authorization, card_request)
      end

      # @param [String] card_id
      def get_card_details(card_id)
        api_client.invoke_get(build_path(ISSUING, CARDS, card_id), sdk_authorization)
      end

      # @param [String] card_id
      # @param [Hash] three_ds_request
      def enroll_three_ds(card_id, three_ds_request)
        api_client.invoke_post(build_path(ISSUING, CARDS, card_id, THREE_DS), sdk_authorization, three_ds_request)
      end

      # @param [String] card_id
      # @param [Hash] three_ds_request
      def update_three_ds_enrollment(card_id, three_ds_request)
        api_client.invoke_patch(build_path(ISSUING, CARDS, card_id, THREE_DS), sdk_authorization, three_ds_request)
      end

      # @param [String] card_id
      def get_card_three_ds_details(card_id)
        api_client.invoke_get(build_path(ISSUING, CARDS, card_id, THREE_DS), sdk_authorization)
      end

      # @param [String] card_id
      def activate_card(card_id)
        api_client.invoke_post(build_path(ISSUING, CARDS, card_id, ACTIVATE), sdk_authorization)
      end

      # @param [String] card_id
      # @param [Hash] query
      def get_card_credentials(card_id, query)
        api_client.invoke_get(build_path(ISSUING, CARDS, card_id, CREDENTIALS), sdk_authorization, query)
      end

      # @param [String] card_id
      # @param [Hash] revoke_request
      def revoke_card(card_id, revoke_request)
        api_client.invoke_post(build_path(ISSUING, CARDS, card_id, REVOKE), sdk_authorization, revoke_request)
      end

      # @param [String] card_id
      # @param [Hash] suspend_request
      def suspend_card(card_id, suspend_request)
        api_client.invoke_post(build_path(ISSUING, CARDS, card_id, SUSPEND), sdk_authorization, suspend_request)
      end

      # @param [Hash] control_request
      def create_control(control_request)
        api_client.invoke_post(build_path(ISSUING, CONTROLS), sdk_authorization, control_request)
      end

      # @param [Hash] controls_query
      def get_card_controls(controls_query)
        api_client.invoke_get(build_path(ISSUING, CONTROLS), sdk_authorization, controls_query)
      end

      # @param [String] control_id
      def get_card_control_details(control_id)
        api_client.invoke_get(build_path(ISSUING, CONTROLS, control_id), sdk_authorization)
      end

      # @param [String] control_id
      # @param [Hash] update_control_request
      def update_card_control(control_id, update_control_request)
        api_client.invoke_put(build_path(ISSUING, CONTROLS, control_id), sdk_authorization, update_control_request)
      end

      # @param [String] control_id
      def remove_card_control(control_id)
        api_client.invoke_delete(build_path(ISSUING, CONTROLS, control_id), sdk_authorization)
      end
    end
  end
end
