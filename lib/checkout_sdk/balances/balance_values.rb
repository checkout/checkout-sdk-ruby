# frozen_string_literal: true

module CheckoutSdk
  module Balances
    # Balance values returned per currency account (swagger schema: Balance).
    #
    # @!attribute pending
    #   @return [Integer] Incoming funds that will be added to Available once cleared.
    # @!attribute available
    #   @return [Integer] Funds available for processing.
    # @!attribute payable
    #   @return [Integer] Funds reserved from Available for outgoing transactions not yet cleared.
    # @!attribute collateral
    #   @return [Integer] Funds held to cover potential liabilities.
    # @!attribute operational
    #   @return [Integer] Funds held for processing Payouts and Issuing payments when Available is insufficient.
    # @!attribute collateral_breakdown
    #   @return [CollateralBreakdown]
    class BalanceValues
      attr_accessor :pending,
                    :available,
                    :payable,
                    :collateral,
                    :operational,
                    :collateral_breakdown
    end
  end
end
