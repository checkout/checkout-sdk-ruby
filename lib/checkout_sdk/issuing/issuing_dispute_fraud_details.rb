# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Fraud-related information required when the dispute reason code is fraud-related.
    # Maps swagger `IssuingDisputeFraudDetails`. Reused by create, escalate and amend dispute
    # requests.
    #
    # @!attribute fraud_type
    #   @return [String] {IssuingDisputeFraudType} The type of fraud the cardholder is asserting.
    #     [Required]
    # @!attribute description
    #   @return [String] Optional free-form description of the fraud.
    class IssuingDisputeFraudDetails
      attr_accessor :fraud_type, :description
    end
  end
end
