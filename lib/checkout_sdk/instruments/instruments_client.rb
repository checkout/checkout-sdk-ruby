# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    class InstrumentsClient < Client
      INSTRUMENTS = 'instruments'
      VALIDATION = 'validation/bank-accounts'
      private_constant :INSTRUMENTS, :VALIDATION

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH
      end

      # @param [InstrumentRequest] create_instrument_request
      def create(create_instrument_request)
        api_client.invoke_post(INSTRUMENTS, sdk_authorization, create_instrument_request)
      end

      # @param [String] instrument_id
      def get(instrument_id)
        api_client.invoke_get(build_path(INSTRUMENTS, instrument_id), sdk_authorization)
      end

      # @param [String] instrument_id
      # @param [UpdateInstrumentRequest] update_instrument_request
      def update(instrument_id, update_instrument_request)
        api_client.invoke_patch(build_path(INSTRUMENTS, instrument_id),
                                sdk_authorization,
                                update_instrument_request)
      end

      # @param [String] instrument_id
      def delete(instrument_id)
        api_client.invoke_delete(build_path(INSTRUMENTS, instrument_id), sdk_authorization)
      end

      # @param [String] country {CheckoutSdk::Common::Country}
      # @param [String] currency {CheckoutSdk::Common::Currency}
      # @param [BankAccountFieldQuery] bank_account_field_query
      def get_bank_account_field_formatting(country, currency, bank_account_field_query)
        api_client.invoke_get(build_path(VALIDATION, country, currency),
                              sdk_authorization(CheckoutSdk::AuthorizationType::OAUTH),
                              bank_account_field_query)
      end
    end
  end
end
