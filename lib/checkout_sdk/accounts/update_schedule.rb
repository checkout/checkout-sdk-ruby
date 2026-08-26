# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute enabled
    #   @return [TrueClass, FalseClass]
    # @!attribute threshold
    #   @return [TrueClass, FalseClass]
    # @!attribute balance_minimum
    #   @return [Integer] The amount, in the minor units of the schedule's currency, to retain in the
    #     sub-entity's available balance. SaaS sellers (ISV) only. Defaults to 0 if you do not set it.
    # @!attribute carry_forward_enabled
    #   @return [TrueClass, FalseClass] Indicates whether to carry forward any balance below the configured
    #     minimum to the next payout. SaaS sellers (ISV) only. Defaults to false if you do not set it.
    # @!attribute payment_instrument_id
    #   @return [String] The ID of the platforms payment instrument used as the payout destination.
    # @!attribute recurrence
    #   @return [ScheduleRequest]
    class UpdateSchedule
      attr_accessor :enabled,
                    :threshold,
                    :balance_minimum,
                    :carry_forward_enabled,
                    :payment_instrument_id,
                    :recurrence
    end
  end
end
