# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for POST /issuing/disputes/{disputeId}/amend.
    # Submit an amendment to a dispute that is currently blocked from proceeding. Maps swagger
    # `amend-dispute-request`. All fields are optional.
    #
    # @!attribute reason
    #   @return [String] The updated four-digit scheme-specific reason code. If not provided, the
    #     existing reason code is retained.
    # @!attribute amount
    #   @return [Numeric] The updated disputed amount, in the minor unit of the transaction currency.
    #     If not provided, the existing amount is retained.
    # @!attribute evidence
    #   @return [Array<Hash>] Evidence supporting the dispute (maps `IssuingDisputeEvidence`).
    # @!attribute fraud_details
    #   @return [IssuingDisputeFraudDetails] Fraud-related details. Required if `reason` specifies a
    #     fraud-related dispute.
    # @!attribute reason_change_justification
    #   @return [String] Justification for changing the reason at the escalation stage. Max 13000
    #     characters.
    # @!attribute action_response
    #   @return [String] Free-form text explaining your choices or asking questions about the
    #     requested changes. Max 1000 characters.
    class AmendDisputeRequest
      attr_accessor :reason, :amount, :evidence, :fraud_details,
                    :reason_change_justification, :action_response
    end
  end
end
