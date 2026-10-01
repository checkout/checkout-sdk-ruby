# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The date the company was incorporated, or the date the sole trader started trading.
    # @!attribute day
    #   The day of the month the company was incorporated.
    #   [Optional]
    #   min 1, max 31
    #   @return [Integer]
    # @!attribute month
    #   The month the company was incorporated.
    #   [Required]
    #   min 1, max 12
    #   @return [Integer]
    # @!attribute year
    #   The year the company was incorporated.
    #   [Required]
    #   min 1500, max 2999
    #   @return [Integer]
    class DateOfIncorporation
      attr_accessor :day,
                    :month,
                    :year
    end
  end
end
