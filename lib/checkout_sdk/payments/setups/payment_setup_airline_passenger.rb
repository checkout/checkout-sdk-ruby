# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Partial address information for a payment setup airline passenger.
    #
    # @!attribute country
    #   @return [String] The passenger's country, as an ISO 3166-1 alpha-2 country code.
    class PaymentSetupAirlinePassengerAddress
      attr_accessor :country
    end

    # A passenger on the flight.
    #
    # @!attribute first_name
    #   @return [String] The passenger's first name.
    # @!attribute last_name
    #   @return [String] The passenger's last name.
    # @!attribute date_of_birth
    #   @return [String] The passenger's date of birth. Format: YYYY-MM-DD.
    # @!attribute address
    #   @return [PaymentSetupAirlinePassengerAddress] The passenger's address.
    class PaymentSetupAirlinePassenger
      attr_accessor :first_name,
                    :last_name,
                    :date_of_birth,
                    :address
    end
  end
end
