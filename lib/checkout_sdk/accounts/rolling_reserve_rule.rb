# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Rolling reserve rule parameters.
    #
    # @!attribute percentage
    #   @return [Float] Min 0, max 100.
    # @!attribute holding_duration
    #   @return [ReserveRuleHoldingDuration]
    class RollingReserveRule
      attr_accessor :percentage, :holding_duration
    end
  end
end
