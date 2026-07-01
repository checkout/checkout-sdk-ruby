# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for POST /issuing/disputes.
    #
    # @!attribute transaction_id
    #   @return [String]
    # @!attribute reason
    #   @return [String]
    # @!attribute evidence
    #   @return [Array<Hash>]
    # @!attribute amount
    #   @return [Numeric]
    # @!attribute presentment_message_id
    #   @return [String]
    # @!attribute fraud_details
    #   @return [IssuingDisputeFraudDetails] Fraud-related information to send with the chargeback.
    #     Required if the dispute has a fraud-related reason code.
    # @!attribute justification
    #   @return [String]
    class CreateDisputeRequest
      attr_accessor :transaction_id, :reason, :evidence, :amount,
                    :presentment_message_id, :fraud_details, :justification
    end
  end
end
