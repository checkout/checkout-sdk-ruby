# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Instruments
      class InstrumentsClient < CheckoutSdk::Instruments::BaseInstrumentsClient
        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
        end

        # @param [Hash, CustomerRequest] create_instrument_request
        def create(create_instrument_request)
          api_client.invoke_post(INSTRUMENTS, sdk_authorization, create_instrument_request)
        end

        # @param [String] instrument_id
        # @param [Hash, UpdateInstrument] update_instrument_request
        def update(instrument_id, update_instrument_request)
          api_client.invoke_patch(build_path(INSTRUMENTS, instrument_id),
                                  sdk_authorization,
                                  update_instrument_request)
        end
      end
    end
  end
end
