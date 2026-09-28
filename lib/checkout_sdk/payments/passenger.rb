# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Contains information about a passenger on the flight.
    #
    # Maps the inline `passenger` item on the swagger `AirlineData` and
    # `PaymentInterfacesProcessingAirlineData` schemas. See {AirlineData#passenger} for the
    # cardinality rule: a single object is accepted on every request surface, an array only on
    # POST /payments.
    #
    # @!attribute first_name
    #   @return [String] The passenger's first name.
    #     [Optional]
    #     Example: "John"
    # @!attribute last_name
    #   @return [String] The passenger's last name.
    #     [Optional]
    #     Example: "White"
    # @!attribute date_of_birth
    #   @return [String] The passenger's date of birth.
    #     [Optional]
    #     Format: date (YYYY-MM-DD)
    #     Example: "1990-05-26"
    # @!attribute address
    #   @return [PassengerAddress] Contains information about the passenger's address.
    #     [Optional]
    class Passenger
      attr_accessor :first_name,
                    :last_name,
                    :date_of_birth,
                    :address
    end

    # Partial address information for an airline passenger.
    #
    # The specification declares exactly one property here, so this is deliberately not the wide
    # {CheckoutSdk::Common::Address}.
    #
    # @!attribute country
    #   @return [String] The two-letter ISO country code of the passenger's country residence.
    #     [Optional]
    #     Example: "US"
    class PassengerAddress
      attr_accessor :country
    end
  end
end
