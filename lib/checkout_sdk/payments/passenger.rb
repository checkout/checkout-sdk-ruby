# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Contains information about a passenger on the flight
    # (PaymentInterfacesProcessingAirlinePassengerData).
    #
    # @!attribute first_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [String] Format: YYYY-MM-DD
    # @!attribute address
    #   @return [PassengerAddress]
    class Passenger
      attr_accessor :first_name,
                    :last_name,
                    :date_of_birth,
                    :address
    end

    # Partial address information for an airline passenger.
    #
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    class PassengerAddress
      attr_accessor :country
    end
  end
end
