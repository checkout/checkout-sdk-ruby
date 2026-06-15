# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdDocumentVerification
      # Request body for POST /id-document-verifications.
      #
      # @!attribute applicant_id
      #   @return [String]
      # @!attribute external_reference
      #   @return [String]
      # @!attribute document_type
      #   @return [String]
      # @!attribute country
      #   @return [String]
      # @!attribute redirect_url
      #   @return [String]
      class IdDocumentVerificationRequest
        attr_accessor :applicant_id,
                      :external_reference,
                      :document_type,
                      :country,
                      :redirect_url
      end
    end
  end
end
