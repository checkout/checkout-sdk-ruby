# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Request body for POST /applepay/enrollments.
    #
    # @!attribute domain
    #   @return [String] Domain to enroll with Apple Pay.
    class ApplePayEnrollmentRequest
      attr_accessor :domain
    end
  end
end
