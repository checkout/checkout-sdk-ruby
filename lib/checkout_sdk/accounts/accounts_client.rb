# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    class AccountsClient < Client
      attr_reader :files_client

      ACCOUNTS = 'accounts'
      ENTITIES = 'entities'
      INSTRUMENT = 'instruments'
      PAYOUT_SCHEDULE = 'payout-schedules'
      FILES = 'files'
      PAYMENT_INSTRUMENTS = 'payment-instruments'
      REQUIREMENTS = 'requirements'
      RESERVE_RULES = 'reserve-rules'
      MEMBERS = 'members'
      private_constant :ACCOUNTS, :ENTITIES, :INSTRUMENT, :PAYOUT_SCHEDULE, :FILES, :PAYMENT_INSTRUMENTS,
                       :REQUIREMENTS, :RESERVE_RULES, :MEMBERS

      # @param [ApiClient] api_client
      # @param [ApiClient] files_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, files_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
        @files_client = files_client
      end

      # @param [Hash, OnboardEntity] entity_request
      def create_entity(entity_request)
        api_client.invoke_post(build_path(ACCOUNTS, ENTITIES), sdk_authorization, entity_request)
      end

      # @param [String] entity_id
      def get_entity(entity_id)
        api_client.invoke_get(build_path(ACCOUNTS, ENTITIES, entity_id), sdk_authorization)
      end

      # @param [String] entity_id
      # @param [Hash, OnboardEntity] entity_request
      def update_entity(entity_id, entity_request)
        api_client.invoke_put(build_path(ACCOUNTS, ENTITIES, entity_id), sdk_authorization, entity_request)
      end

      # @deprecated Please use {#add_payment_instrument} instead
      # @param [String] entity_id
      # @param [Hash, PaymentInstrument] payment_instrument
      def create_payment_instrument(entity_id, payment_instrument)
        api_client.invoke_post(build_path(ACCOUNTS, ENTITIES, entity_id, INSTRUMENT), sdk_authorization,
                               payment_instrument)
      end

      # @param [String] entity_id
      # @param [Hash, PaymentInstrumentRequest] payment_instrument
      def add_payment_instrument(entity_id, payment_instrument)
        api_client.invoke_post(build_path(ACCOUNTS, ENTITIES, entity_id, PAYMENT_INSTRUMENTS), sdk_authorization,
                               payment_instrument)
      end

      # @param [String] entity_id
      # @param [Hash, PaymentInstrumentsQuery,nil] payment_instruments_query
      def query_payment_instruments(entity_id, payment_instruments_query = nil)
        api_client.invoke_get(build_path(ACCOUNTS, ENTITIES, entity_id, PAYMENT_INSTRUMENTS),
                              sdk_authorization,
                              payment_instruments_query)
      end

      # @param [String] entity_id
      # @param [String] payment_instrument_id
      def retrieve_payment_instrument_details(entity_id, payment_instrument_id)
        api_client.invoke_get(build_path(ACCOUNTS, ENTITIES, entity_id, PAYMENT_INSTRUMENTS, payment_instrument_id),
                              sdk_authorization)
      end

      # @param [String] entity_id
      # @param [String] instrument_id
      # @param [Hash, UpdatePaymentInstrumentRequest] update_payment_instrument
      def update_payment_instrument(entity_id, instrument_id, update_payment_instrument)
        api_client.invoke_patch(build_path(ACCOUNTS, ENTITIES, entity_id, PAYMENT_INSTRUMENTS, instrument_id),
                                sdk_authorization,
                                update_payment_instrument)
      end

      # @param [String] entity_id
      # @param [String] currency {CheckoutSdk::Common::Currency}
      # @param [Hash, UpdateSchedule] update_schedule
      def update_payout_schedule(entity_id, currency, update_schedule)
        api_client.invoke_put(build_path(ACCOUNTS, ENTITIES, entity_id, PAYOUT_SCHEDULE), sdk_authorization,
                              { currency => update_schedule })
      end

      # @param [String] entity_id
      def retrieve_payout_schedule(entity_id)
        api_client.invoke_get(build_path(ACCOUNTS, ENTITIES, entity_id, PAYOUT_SCHEDULE), sdk_authorization)
      end

      # @param [Hash, FileRequest] file_request
      def upload_file(file_request)
        files_client.submit_file(FILES, sdk_authorization, file_request)
      end

      # Retrieve the list of pending requirements that a sub-entity must resolve.
      # @param [String] entity_id
      def get_entity_requirements(entity_id)
        api_client.invoke_get(
          build_path(ACCOUNTS, ENTITIES, entity_id, REQUIREMENTS),
          sdk_authorization
        )
      end

      # Retrieve detailed information for a single requirement.
      # @param [String] entity_id
      # @param [String] requirement_id
      def get_entity_requirement_details(entity_id, requirement_id)
        api_client.invoke_get(
          build_path(ACCOUNTS, ENTITIES, entity_id, REQUIREMENTS, requirement_id),
          sdk_authorization
        )
      end

      # Submit a response to resolve a requirement.
      # @param [String] entity_id
      # @param [String] requirement_id
      # @param [Hash, EntityRequirementUpdateRequest] update_request
      def resolve_entity_requirement(entity_id, requirement_id, update_request)
        api_client.invoke_put(
          build_path(ACCOUNTS, ENTITIES, entity_id, REQUIREMENTS, requirement_id),
          sdk_authorization,
          update_request
        )
      end

      # Add a reserve rule for a sub-entity.
      # @param [String] entity_id
      # @param [Hash, ReserveRuleCreateRequest] reserve_rule_request
      def add_reserve_rule(entity_id, reserve_rule_request)
        api_client.invoke_post(
          build_path(ACCOUNTS, ENTITIES, entity_id, RESERVE_RULES),
          sdk_authorization,
          reserve_rule_request
        )
      end

      # Query reserve rules for a sub-entity.
      # @param [String] entity_id
      def query_reserve_rules(entity_id)
        api_client.invoke_get(
          build_path(ACCOUNTS, ENTITIES, entity_id, RESERVE_RULES),
          sdk_authorization
        )
      end

      # Retrieve a reserve rule by id.
      # @param [String] entity_id
      # @param [String] reserve_rule_id
      def get_reserve_rule(entity_id, reserve_rule_id)
        api_client.invoke_get(
          build_path(ACCOUNTS, ENTITIES, entity_id, RESERVE_RULES, reserve_rule_id),
          sdk_authorization
        )
      end

      # Update a reserve rule.
      # The API enforces optimistic concurrency: the ETag returned by GET must be
      # echoed back via {CheckoutSdk::Common::Headers#if_match}, otherwise the
      # API responds 428 Precondition Required.
      # @param [String] entity_id
      # @param [String] reserve_rule_id
      # @param [String] etag ETag value to forward as the `If-Match` HTTP header.
      # @param [Hash, ReserveRuleUpdateRequest] reserve_rule_request
      def update_reserve_rule(entity_id, reserve_rule_id, etag, reserve_rule_request)
        headers = nil
        if !etag.nil? && !etag.empty?
          headers = CheckoutSdk::Common::Headers.new
          headers.if_match = etag
        end

        api_client.invoke_put(
          build_path(ACCOUNTS, ENTITIES, entity_id, RESERVE_RULES, reserve_rule_id),
          sdk_authorization,
          reserve_rule_request,
          headers
        )
      end

      # List sub-entity members.
      # @param [String] entity_id
      def get_sub_entity_members(entity_id)
        api_client.invoke_get(
          build_path(ACCOUNTS, ENTITIES, entity_id, MEMBERS),
          sdk_authorization
        )
      end

      # Reinvite a sub-entity member.
      # The API marks the request body as required; callers must provide a Hash
      # (or `PlatformsHostedOnboardReinviteRequest`-shaped object), even if it
      # is empty `{}` per the current swagger contract.
      # @param [String] entity_id
      # @param [String] user_id
      # @param [Hash] reinvite_request Required body per swagger; pass `{}` if no fields are needed.
      def reinvite_sub_entity_member(entity_id, user_id, reinvite_request)
        api_client.invoke_put(
          build_path(ACCOUNTS, ENTITIES, entity_id, MEMBERS, user_id),
          sdk_authorization,
          reinvite_request
        )
      end

      # Upload a file scoped to a sub-entity. Hits POST /entities/{entityId}/files.
      # @param [String] entity_id
      # @param [Hash, EntityFilesRequest] file_request
      def upload_entity_file(entity_id, file_request)
        files_client.submit_file(
          build_path(ENTITIES, entity_id, FILES),
          sdk_authorization,
          file_request
        )
      end

      # Retrieve a file scoped to a sub-entity. Hits GET /entities/{entityId}/files/{fileId}.
      # @param [String] entity_id
      # @param [String] file_id
      def get_entity_file(entity_id, file_id)
        files_client.invoke_get(
          build_path(ENTITIES, entity_id, FILES, file_id),
          sdk_authorization
        )
      end
    end
  end
end
