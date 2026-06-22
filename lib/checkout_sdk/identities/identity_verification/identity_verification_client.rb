# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # Client for the Identities — Identity Verification API.
      class IdentityVerificationClient < Client
        IDENTITY_VERIFICATIONS = 'identity-verifications'
        CREATE_AND_OPEN_IDV = 'create-and-open-idv'
        ANONYMIZE = 'anonymize'
        ATTEMPTS = 'attempts'
        PDF_REPORT = 'pdf-report'
        ASSETS = 'assets'
        private_constant :IDENTITY_VERIFICATIONS, :CREATE_AND_OPEN_IDV, :ANONYMIZE, :ATTEMPTS, :PDF_REPORT, :ASSETS

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
        end

        # Create an identity verification and immediately receive its hosted URL.
        # @param [Hash, IdentityVerificationRequest] request
        def create_and_open_idv(request)
          api_client.invoke_post(CREATE_AND_OPEN_IDV, sdk_authorization, request)
        end

        # @param [Hash, IdentityVerificationRequest] request
        def create_identity_verification(request)
          api_client.invoke_post(IDENTITY_VERIFICATIONS, sdk_authorization, request)
        end

        # @param [String] identity_verification_id
        def get_identity_verification(identity_verification_id)
          api_client.invoke_get(build_path(IDENTITY_VERIFICATIONS, identity_verification_id),
                                sdk_authorization)
        end

        # @param [String] identity_verification_id
        def anonymize_identity_verification(identity_verification_id)
          api_client.invoke_post(
            build_path(IDENTITY_VERIFICATIONS, identity_verification_id, ANONYMIZE),
            sdk_authorization
          )
        end

        # Create a new attempt for an existing identity verification.
        # @param [String] identity_verification_id
        # @param [Hash, IdentityVerificationAttemptRequest] attempt_request
        def create_identity_verification_attempt(identity_verification_id, attempt_request)
          api_client.invoke_post(
            build_path(IDENTITY_VERIFICATIONS, identity_verification_id, ATTEMPTS),
            sdk_authorization,
            attempt_request
          )
        end

        # @param [String] identity_verification_id
        def get_identity_verification_attempts(identity_verification_id)
          api_client.invoke_get(
            build_path(IDENTITY_VERIFICATIONS, identity_verification_id, ATTEMPTS),
            sdk_authorization
          )
        end

        # @param [String] identity_verification_id
        # @param [String] attempt_id
        def get_identity_verification_attempt(identity_verification_id, attempt_id)
          api_client.invoke_get(
            build_path(IDENTITY_VERIFICATIONS, identity_verification_id, ATTEMPTS, attempt_id),
            sdk_authorization
          )
        end

        # @param [String] identity_verification_id
        def get_identity_verification_pdf_report(identity_verification_id)
          api_client.invoke_get(
            build_path(IDENTITY_VERIFICATIONS, identity_verification_id, PDF_REPORT),
            sdk_authorization
          )
        end

        # Retrieve the assets (face images, videos, and document images) captured during an
        # identity verification attempt.
        # @param [String] identity_verification_id
        # @param [String] attempt_id
        # @param [Hash] query the pagination query parameters (skip and limit)
        def get_identity_verification_attempt_assets(identity_verification_id, attempt_id, query = nil)
          api_client.invoke_get(
            build_path(IDENTITY_VERIFICATIONS, identity_verification_id, ATTEMPTS, attempt_id, ASSETS),
            sdk_authorization,
            query
          )
        end
      end
    end
  end
end
