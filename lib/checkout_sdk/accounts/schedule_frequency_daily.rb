# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # For SaaS sellers (ISV), a daily schedule runs on working days only (Monday to Friday);
    # payouts do not take place on weekends.
    class ScheduleFrequencyDaily < ScheduleRequest
      def initialize
        super(ScheduleFrequencyType::DAILY)
      end
    end
  end
end
