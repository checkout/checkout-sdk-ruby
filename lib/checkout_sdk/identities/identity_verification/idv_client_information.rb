# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # Pre-populated client information for an identity-verification attempt.
      #
      # @!attribute pre_selected_residence_country
      #   @return [String] ISO alpha-2 country code.
      # @!attribute pre_selected_language
      #   @return [String] IETF BCP 47 language tag.
      class IdvClientInformation
        attr_accessor :pre_selected_residence_country, :pre_selected_language
      end
    end
  end
end
