# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Request body for POST /googlepay/enrollments.
    #
    # @!attribute entity_id
    #   @return [String] Entity to enroll.
    # @!attribute email_address
    #   @return [String]
    # @!attribute accept_terms_of_service
    #   @return [Boolean]
    class GooglePayEnrollmentRequest
      attr_accessor :entity_id, :email_address, :accept_terms_of_service
    end
  end
end
