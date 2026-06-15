# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # The personal details provided by the applicant for an identity verification.
      #
      # @!attribute name
      #   @return [String] The applicant's name (max 255 characters).
      class IdvDeclaredData
        attr_accessor :name
      end
    end
  end
end
