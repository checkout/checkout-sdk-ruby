# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute days_between_payments
    #   @return [Integer]
    # @!attribute expiry
    #   @return [String]
    class Recurring
      attr_accessor :days_between_payments,
                    :expiry
    end
  end
end
