# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute source
    #   @return [PayoutRequestSource]
    # @!attribute destination
    #   @return [Destination]
    # @!attribute amount
    #   @return [Integer]
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute reference
    #   @return [String]
    # @!attribute billing_descriptor
    #   @return [PayoutBillingDescriptor]
    # @!attribute sender
    #   @return [Sender]
    # @!attribute instruction
    #   @return [PaymentInstruction]
    # @!attribute processing_channel_id
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    class PayoutRequest
      attr_accessor :source,
                    :destination,
                    :amount,
                    :currency,
                    :reference,
                    :billing_descriptor,
                    :sender,
                    :instruction,
                    :processing_channel_id,
                    :metadata
    end
  end
end
