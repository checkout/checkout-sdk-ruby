# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # An unreferenced refund request, sent to POST /payments.
    # The payment_type is set to UnreferencedRefund by the constructor.
    #
    # @!attribute source
    #   The source of the unreferenced refund.
    #   Only type and id are part of this position; amount is not used.
    #   [Required]
    #   @return [CurrencyAccountSource]
    # @!attribute destination
    #   The destination of the unreferenced refund.
    #   Takes {CardDestination}, {NetworkTokenDestination}, {IdDestination} or {TokenDestination}.
    #   [Required]
    #   @return [Destination]
    # @!attribute instruction
    #   Additional details about the unreferenced refund instruction.
    #   Only funds_transfer_type and purpose are part of this position.
    #   [Optional]
    #   @return [PaymentInstruction]
    # @!attribute amount
    #   The amount in minor currency.
    #   [Required]
    #   Format: int64
    #   min 0
    #   max 9007199254740991
    #   @return [Integer]
    # @!attribute currency
    #   The three-letter ISO currency code of the payment.
    #   [Required]
    #   3 characters
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute payment_type
    #   The type of the payment. Set to UnreferencedRefund by the constructor.
    #   [Required]
    #   Enum: "UnreferencedRefund"
    #   @return [String]
    # @!attribute processing_channel_id
    #   The processing channel identifier.
    #   [Required]
    #   ^(pc)_(\w{26})$
    #   @return [String]
    # @!attribute reference
    #   An internal reference you can later use to identify this payment.
    #   [Optional]
    #   @return [String]
    # @!attribute metadata
    #   A set of key-value pairs that you can attach to the refund request. It can be useful for storing
    #   additional information in a structured format. Note: this object only allows one level of depth,
    #   so cannot accept non-primitive data types such as objects or arrays.
    #   [Optional]
    #   @return [Hash{String => Object}]
    # @!attribute previous_payment_id
    #   The previous related payment identifier. This could be the ID of the payment that you want to refund.
    #   [Optional]
    #   @return [String]
    # @!attribute segment
    #   The dimension details about business segment for payment request. At least one dimension required.
    #   [Optional]
    #   @return [PaymentSegment]
    # @!attribute processing
    #   Returns information related to the processing of the payment.
    #   Only processing_speed is part of this position.
    #   [Optional]
    #   @return [CardPayoutProcessing]
    class UnreferencedRefundRequest
      PAYMENT_TYPE = 'UnreferencedRefund'

      attr_accessor :source,
                    :destination,
                    :instruction,
                    :amount,
                    :currency,
                    :payment_type,
                    :processing_channel_id,
                    :reference,
                    :metadata,
                    :previous_payment_id,
                    :segment,
                    :processing

      def initialize
        @payment_type = PAYMENT_TYPE
      end
    end
  end
end
