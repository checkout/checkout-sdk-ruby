# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for POST /issuing/disputes/{disputeId}/submit. Maps swagger
    # `submit-dispute-request`. All fields are optional.
    #
    # @!attribute reason
    #   @return [String] The updated four-digit scheme-specific reason code. If not provided, the
    #     existing reason code is used.
    # @!attribute evidence
    #   @return [Array<Hash>] Evidence for the chargeback, if updated since you created the dispute
    #     (maps `IssuingDisputeEvidence`).
    # @!attribute amount
    #   @return [Numeric] The updated disputed amount, in the minor unit of the transaction currency.
    #     If not provided, the existing disputed amount is used.
    class SubmitDisputeRequest
      attr_accessor :reason, :evidence, :amount
    end
  end
end
