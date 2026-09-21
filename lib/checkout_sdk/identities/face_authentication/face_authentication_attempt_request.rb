# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module FaceAuthentication
      # Request body for POST /face-authentications/{id}/attempts.
      #
      # @!attribute redirect_url
      #   The URL to redirect the applicant to after the attempt.
      #   [Required]
      #   Format: uri
      #   @return [String]
      # @!attribute phone_number
      #   The applicant's mobile phone number, if sharing the attempt URL via SMS.
      #   [Optional]
      #   @return [CheckoutSdk::Identities::IdvPhoneNumber]
      # @!attribute client_information
      #   The applicant's details. The face authentication attempt takes the narrower
      #   FavClientInformation shape, which declares neither document field, so this is
      #   deliberately the parent class and not IdvIdentityClientInformation.
      #   [Optional]
      #   @return [CheckoutSdk::Identities::IdentityVerification::IdvClientInformation]
      class FaceAuthenticationAttemptRequest
        attr_accessor :redirect_url, :phone_number, :client_information
      end
    end
  end
end
