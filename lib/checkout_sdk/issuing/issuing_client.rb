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
      CONTROL_GROUPS = 'control-groups'
      CONTROL_PROFILES = 'control-profiles'
      SIMULATE = 'simulate'
      AUTHORIZATIONS = 'authorizations'
      PRESENTMENTS = 'presentments'
      REVERSALS = 'reversals'
      REFUNDS = 'refunds'
      RENEW = 'renew'
      DISPUTES = 'disputes'
      CANCEL = 'cancel'
      ESCALATE = 'escalate'
      AMEND = 'amend'
      SUBMIT = 'submit'
      TRANSACTIONS = 'transactions'
      DIGITAL_CARDS = 'digital-cards'
      ADD = 'add'
      REMOVE = 'remove'
      ACCESS = 'access'
      CONNECT = 'connect'
      TOKEN = 'token'
      OOB = 'oob'
      AUTHENTICATION = 'authentication'
      private_constant :ISSUING, :CARDHOLDERS, :CARDS, :THREE_DS, :ACTIVATE, :CREDENTIALS,
                       :REVOKE, :SUSPEND, :CONTROLS, :CONTROL_GROUPS, :CONTROL_PROFILES,
                       :SIMULATE, :AUTHORIZATIONS, :PRESENTMENTS, :REVERSALS, :REFUNDS,
                       :RENEW, :DISPUTES, :CANCEL, :ESCALATE, :AMEND, :SUBMIT,
                       :TRANSACTIONS, :DIGITAL_CARDS, :ADD, :REMOVE

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # ====== Cardholders ======

      # @param [Hash] cardholder_request
      def create_cardholder(cardholder_request)
        api_client.invoke_post(build_path(ISSUING, CARDHOLDERS), sdk_authorization, cardholder_request)
      end

      # @param [String] cardholder_id
      def get_cardholder(cardholder_id)
        api_client.invoke_get(build_path(ISSUING, CARDHOLDERS, cardholder_id), sdk_authorization)
      end

      # @param [String] cardholder_id
      # @param [Hash, UpdateCardholderRequest] update_cardholder_request
      def update_cardholder(cardholder_id, update_cardholder_request)
        api_client.invoke_patch(
          build_path(ISSUING, CARDHOLDERS, cardholder_id),
          sdk_authorization,
          update_cardholder_request
        )
      end

      # @param [String] cardholder_id
      def get_cardholder_cards(cardholder_id)
        api_client.invoke_get(build_path(ISSUING, CARDHOLDERS, cardholder_id, CARDS), sdk_authorization)
      end

      # ====== Cards ======

      # @param [Hash] card_request
      def create_card(card_request)
        api_client.invoke_post(build_path(ISSUING, CARDS), sdk_authorization, card_request)
      end

      # @param [String] card_id
      def get_card_details(card_id)
        api_client.invoke_get(build_path(ISSUING, CARDS, card_id), sdk_authorization)
      end

      # @param [String] card_id
      # @param [Hash, UpdateCardRequest] update_card_request
      def update_card(card_id, update_card_request)
        api_client.invoke_patch(
          build_path(ISSUING, CARDS, card_id),
          sdk_authorization,
          update_card_request
        )
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

      # Renew a card. POST /issuing/cards/{cardId}/renew.
      # @param [String] card_id
      # @param [Hash] renew_request
      def renew_card(card_id, renew_request = nil)
        api_client.invoke_post(
          build_path(ISSUING, CARDS, card_id, RENEW),
          sdk_authorization,
          renew_request
        )
      end

      # ====== Controls (legacy single endpoint) ======

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

      # ====== Control Groups ======

      # @param [Hash, AddControlGroupRequest] control_group_request
      def create_control_group(control_group_request)
        api_client.invoke_post(
          build_path(ISSUING, CONTROLS, CONTROL_GROUPS),
          sdk_authorization,
          control_group_request
        )
      end

      def get_control_groups
        api_client.invoke_get(build_path(ISSUING, CONTROLS, CONTROL_GROUPS), sdk_authorization)
      end

      # @param [String] control_group_id
      def get_control_group(control_group_id)
        api_client.invoke_get(
          build_path(ISSUING, CONTROLS, CONTROL_GROUPS, control_group_id),
          sdk_authorization
        )
      end

      # @param [String] control_group_id
      def delete_control_group(control_group_id)
        api_client.invoke_delete(
          build_path(ISSUING, CONTROLS, CONTROL_GROUPS, control_group_id),
          sdk_authorization
        )
      end

      # ====== Control Profiles ======

      # @param [Hash, AddControlProfileRequest] control_profile_request
      def create_control_profile(control_profile_request)
        api_client.invoke_post(
          build_path(ISSUING, CONTROLS, CONTROL_PROFILES),
          sdk_authorization,
          control_profile_request
        )
      end

      def get_control_profiles
        api_client.invoke_get(build_path(ISSUING, CONTROLS, CONTROL_PROFILES), sdk_authorization)
      end

      # @param [String] control_profile_id
      def get_control_profile(control_profile_id)
        api_client.invoke_get(
          build_path(ISSUING, CONTROLS, CONTROL_PROFILES, control_profile_id),
          sdk_authorization
        )
      end

      # @param [String] control_profile_id
      # @param [Hash, UpdateControlProfileRequest] update_control_profile_request
      def update_control_profile(control_profile_id, update_control_profile_request)
        api_client.invoke_patch(
          build_path(ISSUING, CONTROLS, CONTROL_PROFILES, control_profile_id),
          sdk_authorization,
          update_control_profile_request
        )
      end

      # @param [String] control_profile_id
      def delete_control_profile(control_profile_id)
        api_client.invoke_delete(
          build_path(ISSUING, CONTROLS, CONTROL_PROFILES, control_profile_id),
          sdk_authorization
        )
      end

      # @param [String] control_profile_id
      # @param [String] target_id
      def add_target_to_control_profile(control_profile_id, target_id)
        api_client.invoke_post(
          build_path(ISSUING, CONTROLS, CONTROL_PROFILES, control_profile_id, ADD, target_id),
          sdk_authorization
        )
      end

      # @param [String] control_profile_id
      # @param [String] target_id
      def remove_target_from_control_profile(control_profile_id, target_id)
        api_client.invoke_post(
          build_path(ISSUING, CONTROLS, CONTROL_PROFILES, control_profile_id, REMOVE, target_id),
          sdk_authorization
        )
      end

      # ====== Issuing Disputes ======

      # @param [Hash, CreateDisputeRequest] create_dispute_request
      def create_issuing_dispute(create_dispute_request)
        api_client.invoke_post(
          build_path(ISSUING, DISPUTES),
          sdk_authorization,
          create_dispute_request
        )
      end

      # @param [String] dispute_id
      def get_issuing_dispute(dispute_id)
        api_client.invoke_get(build_path(ISSUING, DISPUTES, dispute_id), sdk_authorization)
      end

      # @param [String] dispute_id
      def cancel_issuing_dispute(dispute_id)
        api_client.invoke_post(
          build_path(ISSUING, DISPUTES, dispute_id, CANCEL),
          sdk_authorization
        )
      end

      # @param [String] dispute_id
      # @param [Hash, EscalateDisputeRequest] escalate_dispute_request
      def escalate_issuing_dispute(dispute_id, escalate_dispute_request)
        api_client.invoke_post(
          build_path(ISSUING, DISPUTES, dispute_id, ESCALATE),
          sdk_authorization,
          escalate_dispute_request
        )
      end

      # Submit an Issuing dispute. POST /issuing/disputes/{disputeId}/submit.
      # @param [String] dispute_id
      # @param [Hash, SubmitDisputeRequest] submit_dispute_request
      # @deprecated Use {#create_issuing_dispute} to create and submit a dispute in one step, or
      #   {#amend_issuing_dispute} when the dispute status is `action_required`.
      def submit_issuing_dispute(dispute_id, submit_dispute_request = nil)
        api_client.invoke_post(
          build_path(ISSUING, DISPUTES, dispute_id, SUBMIT),
          sdk_authorization,
          submit_dispute_request
        )
      end

      # Amend an Issuing dispute. POST /issuing/disputes/{disputeId}/amend.
      # Submit an amendment to a dispute that is currently blocked from proceeding. Handles both
      # chargeback-stage and escalation-stage amendments using the same payload.
      # @param [String] dispute_id
      # @param [Hash, AmendDisputeRequest] amend_dispute_request
      def amend_issuing_dispute(dispute_id, amend_dispute_request = nil)
        api_client.invoke_post(
          build_path(ISSUING, DISPUTES, dispute_id, AMEND),
          sdk_authorization,
          amend_dispute_request
        )
      end

      # ====== Transactions ======

      # @param [Hash] transactions_query
      def get_transactions(transactions_query = nil)
        api_client.invoke_get(
          build_path(ISSUING, TRANSACTIONS),
          sdk_authorization,
          transactions_query
        )
      end

      # @param [String] transaction_id
      def get_transaction(transaction_id)
        api_client.invoke_get(
          build_path(ISSUING, TRANSACTIONS, transaction_id),
          sdk_authorization
        )
      end

      # ====== Digital Cards ======

      # @param [String] digital_card_id
      def get_digital_card(digital_card_id)
        api_client.invoke_get(
          build_path(ISSUING, DIGITAL_CARDS, digital_card_id),
          sdk_authorization
        )
      end

      # ====== Simulations ======

      # @param [Hash] authorization_request
      def simulate_authorization(authorization_request)
        api_client.invoke_post(build_path(ISSUING, SIMULATE, AUTHORIZATIONS), sdk_authorization, authorization_request)
      end

      # @param [String] transaction_id
      # @param [Hash] increment_request
      def simulate_increment(transaction_id, increment_request)
        api_client.invoke_post(
          build_path(ISSUING, SIMULATE, AUTHORIZATIONS, transaction_id, AUTHORIZATIONS),
          sdk_authorization,
          increment_request
        )
      end

      # @param [String] transaction_id
      # @param [Hash] clearing_request
      def simulate_clearing(transaction_id, clearing_request)
        api_client.invoke_post(
          build_path(ISSUING, SIMULATE, AUTHORIZATIONS, transaction_id, PRESENTMENTS),
          sdk_authorization,
          clearing_request
        )
      end

      # @param [String] transaction_id
      # @param [Hash] reversal_request
      def simulate_reversal(transaction_id, reversal_request)
        api_client.invoke_post(
          build_path(ISSUING, SIMULATE, AUTHORIZATIONS, transaction_id, REVERSALS),
          sdk_authorization,
          reversal_request
        )
      end

      # Simulate a refund for an authorization.
      # @param [String] transaction_id
      # @param [Hash, SimulateRefundRequest] refund_request
      def simulate_refund(transaction_id, refund_request)
        api_client.invoke_post(
          build_path(ISSUING, SIMULATE, AUTHORIZATIONS, transaction_id, REFUNDS),
          sdk_authorization,
          refund_request
        )
      end

      # Request a Cardholder access token.
      # The api_client serializes the body as application/x-www-form-urlencoded.
      # @param [Hash, CardholderAccessTokenRequest] cardholder_token_request
      def request_cardholder_access_token(cardholder_token_request)
        api_client.invoke_post(
          build_path(ISSUING, ACCESS, CONNECT, TOKEN),
          sdk_authorization(CheckoutSdk::AuthorizationType::OAUTH),
          cardholder_token_request
        )
      end

      # Simulate an out-of-band (OOB) authentication request.
      # @param [Hash, OobAuthenticationRequest] oob_authentication_request
      def simulate_oob_authentication(oob_authentication_request)
        api_client.invoke_post(
          build_path(ISSUING, SIMULATE, OOB, AUTHENTICATION),
          sdk_authorization(CheckoutSdk::AuthorizationType::OAUTH),
          oob_authentication_request
        )
      end
    end
  end
end
