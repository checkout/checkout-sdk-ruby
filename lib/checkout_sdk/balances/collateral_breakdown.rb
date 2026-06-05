# frozen_string_literal: true

module CheckoutSdk
  module Balances
    # Breakdown of the funds held in the `collateral` balance.
    #
    # @!attribute fixed_reserve
    #   @return [Integer] (required) The portion of the `collateral` balance held as a fixed reserve.
    # @!attribute rolling_reserve
    #   @return [Integer] (required) The portion of the `collateral` balance held as a rolling reserve.
    class CollateralBreakdown
      attr_accessor :fixed_reserve,
                    :rolling_reserve
    end
  end
end
