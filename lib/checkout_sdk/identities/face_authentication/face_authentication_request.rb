# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module FaceAuthentication
      # Request body for POST /face-authentications.
      #
      # @!attribute applicant_id
      #   @return [String]
      # @!attribute external_reference
      #   @return [String]
      # @!attribute redirect_url
      #   @return [String]
      class FaceAuthenticationRequest
        attr_accessor :applicant_id,
                      :external_reference,
                      :redirect_url
      end
    end
  end
end
