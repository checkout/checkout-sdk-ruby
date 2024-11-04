# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute month
    #   @return [Integer]
    # @!attribute year
    #   @return [Integer]
    class DateOfIncorporation
      attr_reader :month,
                  :year
    end
  end
end
