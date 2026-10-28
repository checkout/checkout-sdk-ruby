# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The remittance details of a bank payout instruction, used for reconciliation.
    #
    # @!attribute reference
    #   A merchant-provided reference for the remittance payment.
    #   This value is used for payment reconciliation and is reviewed by our banking partner.
    #   [Optional]
    #   max 80 characters
    #   @return [String]
    class InstructionRemittance
      attr_accessor :reference
    end
  end
end
