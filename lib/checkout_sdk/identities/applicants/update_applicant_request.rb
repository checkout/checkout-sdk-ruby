# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module Applicants
      # Request body for PATCH /applicants/{applicant_id}.
      #
      # @!attribute email
      #   @return [String]
      # @!attribute external_applicant_name
      #   @return [String]
      class UpdateApplicantRequest
        attr_accessor :email,
                      :external_applicant_name
      end
    end
  end
end
