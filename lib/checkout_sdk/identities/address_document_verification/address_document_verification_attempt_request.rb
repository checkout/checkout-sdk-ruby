# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module AddressDocumentVerification
      # Request body for POST /address-document-verifications/{id}/attempts.
      #
      # @!attribute document
      #   @return [String] The address document image to upload. [Required] Format: binary
      class AddressDocumentVerificationAttemptRequest
        attr_accessor :document
      end
    end
  end
end
