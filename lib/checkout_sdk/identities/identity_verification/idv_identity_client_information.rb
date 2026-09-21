# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # The applicant's details for an identity verification attempt.
      #
      # Maps IdvClientInformation, a strict superset of FavClientInformation, so it inherits from
      # {IdvClientInformation}. The face authentication attempt must keep using the parent: its
      # schema declares neither document field, so sending them there would be a request the API
      # rejects.
      #
      # @!attribute pre_selected_document_issuing_country
      #   The country that issued the applicant's identity document.
      #   [Optional]
      #   Standard: ISO 3166-1 alpha-2 country code
      #   ^[A-Z]{2}
      #   Example: FR
      #   @return [String] a value of {CheckoutSdk::Common::Country}
      # @!attribute pre_selected_document_type
      #   The type of identity document the applicant uses for the attempt.
      #   [Optional]
      #   Enum: "Driving licence" "ID" "Other" "Passport" "Residence Permit" "Travel Document" "Visa"
      #   @return [String]
      class IdvIdentityClientInformation < IdvClientInformation
        attr_accessor :pre_selected_document_issuing_country, :pre_selected_document_type
      end
    end
  end
end
