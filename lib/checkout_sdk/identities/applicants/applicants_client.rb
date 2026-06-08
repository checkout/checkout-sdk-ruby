# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module Applicants
      # Client for the Identities — Applicants API.
      class ApplicantsClient < Client
        APPLICANTS = 'applicants'
        ANONYMIZE = 'anonymize'
        private_constant :APPLICANTS, :ANONYMIZE

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
        end

        # @param [Hash, CreateApplicantRequest] create_applicant_request
        def create_applicant(create_applicant_request)
          api_client.invoke_post(APPLICANTS, sdk_authorization, create_applicant_request)
        end

        # @param [String] applicant_id
        def get_applicant(applicant_id)
          api_client.invoke_get(build_path(APPLICANTS, applicant_id), sdk_authorization)
        end

        # @param [String] applicant_id
        # @param [Hash, UpdateApplicantRequest] update_applicant_request
        def update_applicant(applicant_id, update_applicant_request)
          api_client.invoke_put(build_path(APPLICANTS, applicant_id),
                                sdk_authorization,
                                update_applicant_request)
        end

        # @param [String] applicant_id
        def anonymize_applicant(applicant_id)
          api_client.invoke_post(build_path(APPLICANTS, applicant_id, ANONYMIZE), sdk_authorization)
        end
      end
    end
  end
end
