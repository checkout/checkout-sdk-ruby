# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module AddressDocumentVerification
      # Request body for POST /address-document-verifications.
      #
      # @!attribute applicant_id
      #   The applicant's unique identifier.
      #   [Required]
      #   ^aplt_\w+$
      #   @return [String]
      # @!attribute user_journey_id
      #   Your configuration ID.
      #   [Required]
      #   ^usj_[a-z2-7]{26}$
      #   @return [String]
      # @!attribute declared_data
      #   The personal details provided by the applicant. The address document verification
      #   request takes the narrower two field IdvDeclaredData shape, not the identity
      #   verification one.
      #   [Optional]
      #   @return [CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData]
      class AddressDocumentVerificationRequest
        attr_accessor :applicant_id,
                      :user_journey_id,
                      :declared_data
      end
    end
  end
end
