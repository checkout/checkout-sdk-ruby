# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute by_day
    #   @return [Array(String)]
    class ScheduleFrequencyWeekly < ScheduleRequest
      attr_accessor :by_day

      def initialize
        super ScheduleFrequencyType::WEEKLY
      end
    end
  end
end
