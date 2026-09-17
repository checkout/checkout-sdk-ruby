# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The price of the travel insurance.
    #
    # @!attribute amount
    #   @return [Float] The insurance price amount.
    # @!attribute currency
    #   @return [String] The insurance price currency, as a three-letter ISO currency code.
    class PaymentSetupAirlineInsurancePrice
      attr_accessor :amount,
                    :currency
    end

    # Details about the travel insurance purchased with the booking.
    #
    # @!attribute type
    #   @return [String] The type of insurance purchased.
    # @!attribute company
    #   @return [String] The name of the insurance company.
    # @!attribute price
    #   @return [PaymentSetupAirlineInsurancePrice] The price of the insurance.
    class PaymentSetupAirlineInsurance
      attr_accessor :type,
                    :company,
                    :price
    end
  end
end
