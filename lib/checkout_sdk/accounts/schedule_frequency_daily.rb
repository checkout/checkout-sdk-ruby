# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    class ScheduleFrequencyDaily < ScheduleRequest
      def initialize
        super(ScheduleFrequencyType::DAILY)
      end
    end
  end
end
