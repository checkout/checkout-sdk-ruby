# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute by_month_day
    #   @return [Array(Integer)]
    class ScheduleFrequencyMonthly < ScheduleRequest
      attr_accessor :by_month_day

      def initialize
        super(ScheduleFrequencyType::MONTHLY)
      end
    end
  end
end
