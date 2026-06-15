# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module AmlScreening
      # Request body for POST /aml-verifications.
      #
      # @!attribute applicant_id
      #   @return [String] The applicant's unique identifier (e.g. "aplt_...").
      # @!attribute search_parameters
      #   @return [AmlSearchParameters]
      # @!attribute monitored
      #   @return [Boolean] Whether to monitor the applicant's AML status.
      class AmlVerificationRequest
        attr_accessor :applicant_id, :search_parameters, :monitored
      end
    end
  end
end
