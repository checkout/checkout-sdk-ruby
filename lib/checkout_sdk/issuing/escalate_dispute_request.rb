# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for POST /issuing/disputes/{disputeId}/escalate.
    #
    # @!attribute additional_evidence
    #   @return [Array<Hash>]
    # @!attribute amount
    #   @return [Numeric]
    # @!attribute reason_change
    #   @return [String]
    # @!attribute fraud_details
    #   @return [IssuingDisputeFraudDetails] Fraud-related details. Required if the dispute has a
    #     fraud-related reason code at the escalation stage, or after a reason-code change to a
    #     fraud code.
    # @!attribute justification
    #   @return [String] Required.
    class EscalateDisputeRequest
      attr_accessor :additional_evidence, :amount, :reason_change, :fraud_details, :justification
    end
  end
end
