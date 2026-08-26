# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute by_month_day
    #   @return [Array(Integer)] The day or days of the month the payout should take place.
    #     For SaaS sellers (ISV), only the following combinations are supported, in any order:
    #     [1], [15], [1, 15] or [1, 16].
    class ScheduleFrequencyMonthly < ScheduleRequest
      attr_accessor :by_month_day

      def initialize
        super(ScheduleFrequencyType::MONTHLY)
      end
    end
  end
end
