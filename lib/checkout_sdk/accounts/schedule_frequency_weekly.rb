# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute by_day
    #   @return [Array(String)] The day or days of the week the payout should take place.
    #     For SaaS sellers (ISV), only working days (Monday to Friday) are supported;
    #     payouts set to take place on weekends are rejected.
    class ScheduleFrequencyWeekly < ScheduleRequest
      attr_accessor :by_day

      def initialize
        super(ScheduleFrequencyType::WEEKLY)
      end
    end
  end
end
