# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute frequency
    #   @return [String] {ScheduleFrequencyType}
    class ScheduleRequest
      attr_reader :frequency

      protected

      # @abstract
      # @param [String] frequency {ScheduleFrequencyType}
      def initialize(frequency)
        @frequency = frequency
      end
    end
  end
end
