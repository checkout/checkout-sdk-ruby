# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module FaceAuthentication
      # Request body for POST /face-authentications/{id}/attempts.
      #
      # @!attribute redirect_url
      #   @return [String] URL to redirect the applicant after the attempt.
      # @!attribute client_information
      #   @return [CheckoutSdk::Identities::IdentityVerification::IdvClientInformation]
      class FaceAuthenticationAttemptRequest
        attr_accessor :redirect_url, :client_information
      end
    end
  end
end
