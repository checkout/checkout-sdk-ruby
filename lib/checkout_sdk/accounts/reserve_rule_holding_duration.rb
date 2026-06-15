# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The length of time a rolling reserve collateral balance is held for.
    #
    # @!attribute weeks
    #   @return [Integer] Min 2, max 104.
    class ReserveRuleHoldingDuration
      attr_accessor :weeks
    end
  end
end
