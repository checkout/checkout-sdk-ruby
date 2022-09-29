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
    end
  end
end
