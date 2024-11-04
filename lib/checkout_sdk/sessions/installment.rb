# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute number_of_payments
    #   @return [Integer]
    # @!attribute days_between_payments
    #   @return [Integer]
    # @!attribute expiry
    #   @return [String]
    class Installment
      attr_accessor :number_of_payments,
                    :days_between_payments,
                    :expiry

      def initialize(days_between_payments: 1, expiry: '99991231')
        @days_between_payments = days_between_payments
        @expiry = expiry
      end
    end
  end
end
