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
      private_constant :ACCOUNTS, :ENTITIES, :INSTRUMENT, :PAYOUT_SCHEDULE, :FILES

      # @param [ApiClient] api_client
      # @param [ApiClient] files_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, files_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::OAUTH)
        @files_client = files_client
      end

      # @param [OnboardEntity] entity_request
      def create_entity(entity_request)
        api_client.invoke_post(build_path(ACCOUNTS, ENTITIES), sdk_authorization, entity_request)
      end

      # @param [String] entity_id
      def get_entity(entity_id)
        api_client.invoke_get(build_path(ACCOUNTS, ENTITIES, entity_id), sdk_authorization)
      end

      # @param [String] entity_id
      # @param [OnboardEntity] entity_request
      def update_entity(entity_id, entity_request)
        api_client.invoke_put(build_path(ACCOUNTS, ENTITIES, entity_id), sdk_authorization, entity_request)
      end

      # @param [String] entity_id
      # @param [PaymentInstrument] payment_instrument
      def create_payment_instrument(entity_id, payment_instrument)
        api_client.invoke_post(build_path(ACCOUNTS, ENTITIES, entity_id, INSTRUMENT), sdk_authorization,
                               payment_instrument)
      end

      # @param [String] entity_id
      # @param [String] currency {CheckoutSdk::Common::Currency}
      # @param [UpdateSchedule] update_schedule
      def update_payout_schedule(entity_id, currency, update_schedule)
        api_client.invoke_put(build_path(ACCOUNTS, ENTITIES, entity_id, PAYOUT_SCHEDULE), sdk_authorization,
                              { currency => update_schedule })
      end

      # @param [String] entity_id
      def retrieve_payout_schedule(entity_id)
        api_client.invoke_get(build_path(ACCOUNTS, ENTITIES, entity_id, PAYOUT_SCHEDULE), sdk_authorization)
      end

      # @param [FileRequest] file_request
      def upload_file(file_request)
        files_client.submit_file(FILES, sdk_authorization, file_request)
      end
    end
  end
end
