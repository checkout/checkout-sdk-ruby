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
      private_constant :ACCOUNTS, :ENTITIES, :INSTRUMENT, :PAYOUT_SCHEDULE, :FILES, :PAYMENT_INSTRUMENTS

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
    end
  end
end
