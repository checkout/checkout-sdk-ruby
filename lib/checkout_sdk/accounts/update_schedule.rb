# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute enabled
    #   @return [TrueClass, FalseClass]
    # @!attribute threshold
    #   @return [TrueClass, FalseClass]
    # @!attribute recurrence
    #   @return [ScheduleRequest]
    class UpdateSchedule
      attr_accessor :enabled,
                    :threshold,
                    :recurrence
    end
  end
end
