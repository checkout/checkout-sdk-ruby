# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module Applicants
      # Request body for POST /applicants.
      #
      # @!attribute external_applicant_id
      #   @return [String]
      # @!attribute email
      #   @return [String]
      # @!attribute external_applicant_name
      #   @return [String]
      class CreateApplicantRequest
        attr_accessor :external_applicant_id,
                      :email,
                      :external_applicant_name
      end
    end
  end
end
