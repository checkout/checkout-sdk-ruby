# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module AddressDocumentVerification
      # Request body for POST /address-document-verifications.
      #
      # @!attribute applicant_id
      #   @return [String] The applicant's unique identifier. [Required] Pattern: ^aplt_\w+$
      # @!attribute user_journey_id
      #   @return [String] Your configuration ID. [Required] Pattern: ^usj_[a-z2-7]{26}$
      # @!attribute declared_data
      #   @return [IdvDeclaredData, Hash] The personal details provided by the applicant. [Optional]
      class AddressDocumentVerificationRequest
        attr_accessor :applicant_id,
                      :user_journey_id,
                      :declared_data
      end
    end
  end
end
