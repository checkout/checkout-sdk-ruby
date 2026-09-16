# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Industry-specific details for the payment setup.
    #
    # @!attribute accommodation
    #   @return [Array(PaymentSetupAccommodation)] The list of accommodation bookings associated
    #     with the payment setup.
    # @!attribute airline
    #   @return [Array(PaymentSetupAirline)] The list of airline bookings associated with the
    #     payment setup.
    class PaymentSetupIndustry
      attr_accessor :accommodation,
                    :airline
    end
  end
end
