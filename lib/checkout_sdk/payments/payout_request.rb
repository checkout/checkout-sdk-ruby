# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A card payout or bank payout request, sent to POST /payments.
    #
    # @!attribute source
    #   The source of the payout. For bank payouts, the source from which the payout is funded.
    #   [Required]
    #   @return [PayoutSource]
    # @!attribute destination
    #   The destination of the payout.
    #   You can encrypt this field by using the Cko-Encryption-Key-Id and Cko-Encrypted-Properties headers.
    #   Card payouts take {CardDestination}, {NetworkTokenDestination}, {IdDestination} or {TokenDestination};
    #   bank payouts take {IdDestination} or {BankAccountDestination}.
    #   [Required]
    #   @return [Destination]
    # @!attribute amount
    #   The amount to pay out, in minor units.
    #   [Optional] for card payouts, [Required] for bank payouts
    #   min 0
    #   @return [Integer]
    # @!attribute currency
    #   The three-letter ISO 4217 code for the currency you want to pay out to the recipient.
    #   For bank payouts, it should match the currency of the destination account.
    #   [Required]
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute reference
    #   A custom reference to identify the payout. For example, an order number.
    #   [Optional]
    #   max 50 characters for card payouts
    #   @return [String]
    # @!attribute billing_descriptor
    #   The billing descriptor for bank payouts. Beneficiary banks typically construct it using the
    #   billing descriptor reference and the sender information.
    #   [Required] for bank payouts, not used by card payouts
    #   @return [PayoutBillingDescriptor]
    # @!attribute sender
    #   The sender of the payout. Required for money transfer card payouts. For bank payouts, the
    #   ultimate sender of the payout, that is, your customer; not supported for Platform or Direct
    #   Seller Checkout.com clients.
    #   [Optional]
    #   @return [Sender]
    # @!attribute instruction
    #   Additional details about the payout instruction.
    #   [Required] for card payouts, [Optional] for bank payouts
    #   @return [PaymentInstruction]
    # @!attribute processing_channel_id
    #   The unique identifier for the processing channel.
    #   [Required]
    #   ^(pc)_(\w{26})$
    #   29 characters
    #   @return [String]
    # @!attribute metadata
    #   Stores additional information about the transaction with custom fields. Card payouts only.
    #   [Optional]
    #   @return [Hash{String => Object}]
    # @!attribute segment
    #   The dimension details about business segment for payment request. At least one dimension required.
    #   [Optional]
    #   @return [PaymentSegment]
    # @!attribute items
    #   The order's line items. Card payouts only.
    #   [Optional]
    #   @return [Array(CardPayoutItem)]
    # @!attribute previous_payment_id
    #   The identifier of an existing payment from the recurring series, if the payout is a recurring
    #   payment that uses stored card details. If the card payout is linked to a previous Account
    #   Funding Transaction (AFT), include the previous payment's ID when Checkout.com processed the
    #   AFT, or the scheme's transaction ID when another payment service provider processed it.
    #   Card payouts only.
    #   [Optional]
    #   @return [String]
    # @!attribute processing
    #   Information related to the processing of the payout. Card payouts only.
    #   [Optional]
    #   @return [CardPayoutProcessing]
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
                    :metadata,
                    :segment,
                    :items,
                    :previous_payment_id,
                    :processing
    end
  end
end
