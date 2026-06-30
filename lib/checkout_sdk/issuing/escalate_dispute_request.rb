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
    # @!attribute justification
    #   @return [String] Required.
    class EscalateDisputeRequest
      attr_accessor :additional_evidence, :amount, :reason_change, :justification
    end
  end
end
