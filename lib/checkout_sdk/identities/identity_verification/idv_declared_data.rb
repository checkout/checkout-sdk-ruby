# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # The personal details provided by the applicant.
      #
      # Maps IdvDeclaredData, the shape the address document and ID document verification requests
      # accept. The identity verification requests take the larger {IdvIdentityDeclaredData}.
      #
      # @!attribute name
      #   The applicant's name.
      #   [Required]
      #   min 2 characters, max 255 characters
      #   Example: Hannah Bret
      #   @return [String]
      # @!attribute birth_date
      #   The applicant's birth date.
      #   [Optional]
      #   Format: yyyy-MM-dd
      #   Example: 1994-10-15
      #   @return [String]
      class IdvDeclaredData
        attr_accessor :name, :birth_date
      end
    end
  end
end
