# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # The personal details provided by the applicant for an identity verification.
      #
      # Maps IdvIdentityDeclaredData, a strict superset of IdvDeclaredData, so it inherits from it.
      # The address document and ID document verification requests take the smaller
      # {IdvDeclaredData} shape instead: sending these three extra fields there would be a request
      # the API rejects.
      #
      # @!attribute phone_number
      #   The applicant's mobile phone number, if sharing the attempt URL via SMS.
      #   [Optional]
      #   @return [CheckoutSdk::Identities::IdvPhoneNumber]
      # @!attribute email
      #   The applicant's email address. Explicitly nullable in the spec, so the API may return
      #   null for it rather than omitting it.
      #   [Optional]
      #   Format: email
      #   Nullable: true
      #   Example: hannah.bret@example.com
      #   @return [String]
      # @!attribute address
      #   The applicant's address.
      #   [Optional]
      #   @return [CheckoutSdk::Identities::IdvAddress]
      class IdvIdentityDeclaredData < IdvDeclaredData
        attr_accessor :phone_number, :email, :address
      end
    end
  end
end
