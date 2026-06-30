# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module AmlScreening
      # Client for the Identities — AML Screening API.
      class AmlScreeningClient < Client
        AML_VERIFICATIONS = 'aml-verifications'
        private_constant :AML_VERIFICATIONS

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
        end

        # @param [Hash, AmlVerificationRequest] aml_verification_request
        def create_aml_verification(aml_verification_request)
          api_client.invoke_post(AML_VERIFICATIONS, sdk_authorization, aml_verification_request)
        end

        # @param [String] aml_verification_id
        def get_aml_verification(aml_verification_id)
          api_client.invoke_get(build_path(AML_VERIFICATIONS, aml_verification_id), sdk_authorization)
        end
      end
    end
  end
end
