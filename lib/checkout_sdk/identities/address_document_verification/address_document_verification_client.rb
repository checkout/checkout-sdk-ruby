# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module AddressDocumentVerification
      # Client for the Identities — Address Document Verification (Adv) API.
      class AddressDocumentVerificationClient < Client
        ADDRESS_DOCUMENT_VERIFICATIONS = 'address-document-verifications'
        ANONYMIZE = 'anonymize'
        ATTEMPTS = 'attempts'
        PDF_REPORT = 'pdf-report'
        private_constant :ADDRESS_DOCUMENT_VERIFICATIONS, :ANONYMIZE, :ATTEMPTS, :PDF_REPORT

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
        end

        # @param [Hash, AddressDocumentVerificationRequest] request
        def create_address_document_verification(request)
          api_client.invoke_post(ADDRESS_DOCUMENT_VERIFICATIONS, sdk_authorization, request)
        end

        # @param [String] address_document_verification_id
        def get_address_document_verification(address_document_verification_id)
          api_client.invoke_get(
            build_path(ADDRESS_DOCUMENT_VERIFICATIONS, address_document_verification_id),
            sdk_authorization
          )
        end

        # @param [String] address_document_verification_id
        def anonymize_address_document_verification(address_document_verification_id)
          api_client.invoke_post(
            build_path(ADDRESS_DOCUMENT_VERIFICATIONS, address_document_verification_id, ANONYMIZE),
            sdk_authorization
          )
        end

        # Create a new attempt for an existing address document verification.
        # @param [String] address_document_verification_id
        # @param [Hash, AddressDocumentVerificationAttemptRequest] attempt_request
        def create_address_document_verification_attempt(address_document_verification_id, attempt_request = nil)
          api_client.invoke_post(
            build_path(ADDRESS_DOCUMENT_VERIFICATIONS, address_document_verification_id, ATTEMPTS),
            sdk_authorization,
            attempt_request
          )
        end

        # @param [String] address_document_verification_id
        def get_address_document_verification_attempts(address_document_verification_id)
          api_client.invoke_get(
            build_path(ADDRESS_DOCUMENT_VERIFICATIONS, address_document_verification_id, ATTEMPTS),
            sdk_authorization
          )
        end

        # @param [String] address_document_verification_id
        # @param [String] attempt_id
        def get_address_document_verification_attempt(address_document_verification_id, attempt_id)
          api_client.invoke_get(
            build_path(ADDRESS_DOCUMENT_VERIFICATIONS, address_document_verification_id, ATTEMPTS, attempt_id),
            sdk_authorization
          )
        end

        # @param [String] address_document_verification_id
        def get_address_document_verification_pdf_report(address_document_verification_id)
          api_client.invoke_get(
            build_path(ADDRESS_DOCUMENT_VERIFICATIONS, address_document_verification_id, PDF_REPORT),
            sdk_authorization
          )
        end
      end
    end
  end
end
