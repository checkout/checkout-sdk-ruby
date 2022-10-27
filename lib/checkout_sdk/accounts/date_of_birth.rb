# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute day
    #   @return [Integer]
    # @!attribute month
    #   @return [Integer]
    # @!attribute year
    #   @return [Integer]
    class DateOfBirth
      attr_accessor :day,
                    :month,
                    :year
    end
  end
end
