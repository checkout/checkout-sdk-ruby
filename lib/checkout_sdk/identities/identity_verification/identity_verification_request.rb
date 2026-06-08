# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # Request body for POST /identity-verifications and POST /create-and-open-idv.
      #
      # @!attribute applicant_id
      #   @return [String] The applicant's unique identifier (e.g. "aplt_...").
      # @!attribute user_journey_id
      #   @return [String] Your configuration ID (e.g. "usj_...").
      # @!attribute declared_data
      #   @return [IdvDeclaredData]
      # @!attribute risk_labels
      #   @return [Array<String>]
      class IdentityVerificationRequest
        attr_accessor :applicant_id, :user_journey_id, :declared_data, :risk_labels
      end
    end
  end
end
