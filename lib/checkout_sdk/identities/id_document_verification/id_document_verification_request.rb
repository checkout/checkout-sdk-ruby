# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdDocumentVerification
      # Request body for POST /id-document-verifications.
      #
      # Realigned with the spec on 2026-09-21. This class previously declared
      # external_reference, document_type, country and redirect_url, none of which
      # IddvIdDocumentVerification declares, and omitted user_journey_id and declared_data, which
      # it does. The four invented attributes are retained rather than removed, so no caller
      # breaks, and are scheduled for removal in a future major; the API ignores them.
      #
      # @!attribute applicant_id
      #   The applicant's unique identifier.
      #   [Required]
      #   ^aplt_\w+$
      #   @return [String]
      # @!attribute user_journey_id
      #   Your configuration ID.
      #   [Optional]
      #   ^usj_[a-z2-7]{26}$
      #   @return [String]
      # @!attribute declared_data
      #   The personal details provided by the applicant. The ID document verification request
      #   takes the narrower two field IdvDeclaredData shape.
      #   [Optional]
      #   @return [CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData]
      # @!attribute external_reference
      #   @deprecated Not declared by IddvIdDocumentVerification. Never sent by the API and
      #     ignored if supplied. Scheduled for removal in a future major.
      #   @return [String]
      # @!attribute document_type
      #   @deprecated Not declared by IddvIdDocumentVerification. The document type is chosen by
      #     the applicant during the attempt and returned on the response, not sent on the
      #     request. Scheduled for removal in a future major.
      #   @return [String]
      # @!attribute country
      #   @deprecated Not declared by IddvIdDocumentVerification. Scheduled for removal in a
      #     future major.
      #   @return [String]
      # @!attribute redirect_url
      #   @deprecated Not declared by IddvIdDocumentVerification. The redirect URL belongs on the
      #     attempt request, not the verification. Scheduled for removal in a future major.
      #   @return [String]
      class IdDocumentVerificationRequest
        attr_accessor :applicant_id,
                      :user_journey_id,
                      :declared_data,
                      :external_reference,
                      :document_type,
                      :country,
                      :redirect_url
      end
    end
  end
end
