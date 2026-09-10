# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The amount and currency to present to the customer, when the settlement
    # currency differs from the customer-facing currency.
    #
    # @!attribute amount
    #   @return [Integer] The presentment amount, in the minor currency unit.
    # @!attribute currency
    #   @return [String] The presentment currency, as a three-letter ISO currency code.
    class PaymentSetupPresentmentDetails
      attr_accessor :amount,
                    :currency
    end
  end
end
