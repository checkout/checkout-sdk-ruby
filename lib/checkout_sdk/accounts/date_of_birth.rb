# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The date of birth of the person according to the Gregorian calendar.
    # @!attribute day
    #   The calendar day of the month they were born.
    #   [Required]
    #   min 1, max 31
    #   @return [Integer]
    # @!attribute month
    #   The month of the year they were born.
    #   [Required]
    #   min 1, max 12
    #   @return [Integer]
    # @!attribute year
    #   The year they were born.
    #   [Required]
    #   min 1900, max 2999
    #   @return [Integer]
    class DateOfBirth
      attr_accessor :day,
                    :month,
                    :year
    end
  end
end
