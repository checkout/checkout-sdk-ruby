# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The sender of a payment or a payout. Set the subclass that matches the sender type.
    # - Card payouts (money transfers): {IndividualSender}, {CorporateSender}, {GovernmentSender}.
    # - Bank payouts: {IndividualSender}, {CorporateSender}, {InstrumentSender}. Not supported for Platform or
    #   Direct Seller Checkout.com clients.
    # - Regular payments (PaymentRequest): {IndividualSender}, {CorporateSender}, {InstrumentSender}.
    #
    # @!attribute type
    #   The sender type. Set by each subclass.
    #   [Required]
    #   Enum: "individual" "corporate" "government" (card payouts); "instrument" "individual" "corporate"
    #   (bank payouts and regular payments)
    #   @return [String] {SenderType}
    # @!attribute reference
    #   For card payouts, the unique identifier for the sender, for example a customer number; only
    #   alphanumeric characters are supported. For bank payouts, a unique reference to the underlying
    #   client's customer, a global KYC requirement. For regular payments, the unique reference for the
    #   sender of the payment.
    #   [Required] for card payouts and bank payouts, [Optional] for regular payments
    #   min 5 characters, max 15 characters for card payouts
    #   @return [String]
    class Sender
      attr_reader :type
      attr_accessor :reference

      protected

      # @abstract
      # @param [String] type {SenderType}
      def initialize(type)
        @type = type
      end
    end
  end
end
