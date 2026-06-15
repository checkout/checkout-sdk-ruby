# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # Request body for POST /identity-verifications/{id}/attempts.
      #
      # @!attribute redirect_url
      #   @return [String] URL to redirect the applicant after the attempt.
      # @!attribute client_information
      #   @return [IdvClientInformation]
      class IdentityVerificationAttemptRequest
        attr_accessor :redirect_url, :client_information
      end
    end
  end
end
