# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # The applicant's details for a face authentication attempt.
      #
      # Maps FavClientInformation. Deliberately smaller than
      # {IdvIdentityClientInformation}, which adds the two fields only the identity verification
      # attempt accepts. Shared with the face authentication attempt, so do not add IDV only
      # fields here.
      #
      # @!attribute pre_selected_residence_country
      #   The applicant's residence country.
      #   [Optional]
      #   Standard: ISO 3166-1 alpha-2 country code
      #   ^[A-Z]{2}
      #   Example: FR
      #   @return [String] a value of {CheckoutSdk::Common::Country}
      # @!attribute pre_selected_language
      #   The language you want to use for the user interface.
      #   [Optional]
      #   Format: IETF BCP 47 language tag
      #   Example: en-US
      #   @return [String]
      class IdvClientInformation
        attr_accessor :pre_selected_residence_country, :pre_selected_language
      end
    end
  end
end
