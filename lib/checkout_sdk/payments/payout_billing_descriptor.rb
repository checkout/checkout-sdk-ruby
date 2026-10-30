# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The billing descriptor of a bank payout. Beneficiary banks typically construct the billing descriptor
    # using the billing descriptor reference and sender information. For direct sellers, the sender is
    # typically your entity's legal company name. If the ultimate sender is provided, then it is the values
    # of the Sender object.
    #
    # @!attribute reference
    #   The reference shown on the beneficiary's bank statement. The length varies per beneficiary bank;
    #   in general, fewer than 11 characters are recommended. References are not supported in the US.
    #   [Required]
    #   min 11 characters
    #   max 15 characters
    #   @return [String]
    class PayoutBillingDescriptor
      attr_accessor :reference
    end
  end
end
