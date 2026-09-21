# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdDocumentVerification
      # Client for the Identities — ID Document Verification API.
      class IdDocumentVerificationClient < Client
        ID_DOCUMENT_VERIFICATIONS = 'id-document-verifications'
        ANONYMIZE = 'anonymize'
        ATTEMPTS = 'attempts'
        PDF_REPORT = 'pdf-report'
        ASSETS = 'assets'
        private_constant :ID_DOCUMENT_VERIFICATIONS, :ANONYMIZE, :ATTEMPTS, :PDF_REPORT, :ASSETS

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
        end

        # @param [Hash, IdDocumentVerificationRequest] request
        def create_id_document_verification(request)
          api_client.invoke_post(ID_DOCUMENT_VERIFICATIONS, sdk_authorization, request)
        end

        # @param [String] id_document_verification_id
        def get_id_document_verification(id_document_verification_id)
          api_client.invoke_get(build_path(ID_DOCUMENT_VERIFICATIONS, id_document_verification_id),
                                sdk_authorization)
        end

        # @param [String] id_document_verification_id
        def anonymize_id_document_verification(id_document_verification_id)
          api_client.invoke_post(
            build_path(ID_DOCUMENT_VERIFICATIONS, id_document_verification_id, ANONYMIZE),
            sdk_authorization
          )
        end

        # Create a new attempt for an existing ID document verification.
        # @param [String] id_document_verification_id
        # @param [Hash] attempt_request Optional body per swagger.
        def create_id_document_verification_attempt(id_document_verification_id, attempt_request = nil)
          api_client.invoke_post(
            build_path(ID_DOCUMENT_VERIFICATIONS, id_document_verification_id, ATTEMPTS),
            sdk_authorization,
            attempt_request
          )
        end

        # Get the details of all attempts for a specific ID document verification.
        #
        # Results are paginated. Beta.
        #
        # @param [String] id_document_verification_id
        # @param [Hash, CheckoutSdk::Identities::IdvAttemptsQueryFilter, nil] query pagination
        #   query parameters; supports :skip (Integer, default: 0) and :limit (Integer, default: 10)
        # @return [OpenStruct] the paginated attempt list
        def get_id_document_verification_attempts(id_document_verification_id, query = nil)
          api_client.invoke_get(
            build_path(ID_DOCUMENT_VERIFICATIONS, id_document_verification_id, ATTEMPTS),
            sdk_authorization,
            query
          )
        end

        # @param [String] id_document_verification_id
        # @param [String] attempt_id
        def get_id_document_verification_attempt(id_document_verification_id, attempt_id)
          api_client.invoke_get(
            build_path(ID_DOCUMENT_VERIFICATIONS, id_document_verification_id, ATTEMPTS, attempt_id),
            sdk_authorization
          )
        end

        # @param [String] id_document_verification_id
        def get_id_document_verification_pdf_report(id_document_verification_id)
          api_client.invoke_get(
            build_path(ID_DOCUMENT_VERIFICATIONS, id_document_verification_id, PDF_REPORT),
            sdk_authorization
          )
        end

        # Get the assets (the front and back images of the document) uploaded for an ID document
        # verification attempt.
        #
        # Results are paginated. Beta.
        #
        # @param [String] id_document_verification_id
        # @param [String] attempt_id
        # @param [Hash, CheckoutSdk::Identities::IdvAttemptAssetsQueryFilter, nil] query pagination
        #   query parameters; supports :skip (Integer, default: 0) and :limit (Integer, default: 10)
        # @return [OpenStruct] the paginated asset list
        def get_id_document_verification_attempt_assets(id_document_verification_id,
                                                        attempt_id,
                                                        query = nil)
          api_client.invoke_get(
            build_path(ID_DOCUMENT_VERIFICATIONS, id_document_verification_id,
                       ATTEMPTS, attempt_id, ASSETS),
            sdk_authorization,
            query
          )
        end
      end
    end
  end
end
