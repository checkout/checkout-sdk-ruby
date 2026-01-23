# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Apm
      class SepaClient < Client
        APMS = 'apms'
        SEPA_MANDATES = 'sepa/mandates'
        PPRO = 'ppro'
        CANCEL = 'cancel'
        private_constant :APMS, :SEPA_MANDATES, :PPRO, :CANCEL

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
        end

        # @param mandate_id [String]
        def get_mandate(mandate_id)
          api_client.invoke_get(build_path(SEPA_MANDATES, mandate_id), sdk_authorization)
        end

        # @param mandate_id [String]
        def cancel_mandate(mandate_id)
          api_client.invoke_post(build_path(SEPA_MANDATES, mandate_id, CANCEL), sdk_authorization)
        end

        # @param mandate_id [String]
        def get_mandate_via_ppro(mandate_id)
          api_client.invoke_get(build_path(APMS, PPRO, SEPA_MANDATES, mandate_id), sdk_authorization)
        end

        # @param mandate_id [String]
        def cancel_mandate_via_ppro(mandate_id)
          api_client.invoke_post(build_path(APMS, PPRO, SEPA_MANDATES, mandate_id, CANCEL), sdk_authorization)
        end
      end
    end
  end
end
