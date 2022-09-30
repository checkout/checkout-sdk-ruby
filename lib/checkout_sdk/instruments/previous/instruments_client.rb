# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Instruments
      class InstrumentsClient < Client
        INSTRUMENTS = 'instruments'
        private_constant :INSTRUMENTS

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY
        end

        # @param [CustomerRequest] create_instrument_request
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
      end
    end
  end
end
