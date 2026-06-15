# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Details for a simulated OOB authentication transaction.
    #
    # @!attribute last_four
    #   @return [String] The last four digits of the card.
    # @!attribute merchant_name
    #   @return [String]
    # @!attribute purchase_amount
    #   @return [Numeric]
    # @!attribute purchase_currency
    #   @return [String] ISO currency (e.g. "GBP").
    class OobSimulateTransactionDetails
      attr_accessor :last_four, :merchant_name, :purchase_amount, :purchase_currency
    end
  end
end
