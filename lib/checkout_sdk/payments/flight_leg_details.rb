# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Contains information about a flight leg booked by the customer.
    #
    # Maps the inline `flight_leg_details` item on the swagger `AirlineData` and
    # `PaymentInterfacesProcessingAirlineData` schemas, and `PaymentSetupFlightLegDetails` for
    # payment setups. All three declare the same nine properties with the same spelling, which is
    # why one class serves the payments and the setups paths.
    #
    # @!attribute flight_number
    #   @return [String] The flight number.
    #     [Optional]
    #     Example: "101"
    # @!attribute carrier_code
    #   @return [String] The IATA carrier code.
    #     [Optional]
    #     Example: "BA"
    # @!attribute class_of_travelling
    #   @return [String] The fare class of the leg.
    #     [Optional]
    #     Example: "J"
    # @!attribute departure_date
    #   @return [String] The date the flight departs.
    #     [Optional]
    #     Format: date (YYYY-MM-DD)
    #     Example: "2023-06-19"
    # @!attribute departure_time
    #   @return [String] The local time the flight departs.
    #     [Optional]
    #     Example: "15:30"
    # @!attribute departure_airport
    #   @return [String] The IATA code of the departure airport.
    #     [Optional]
    #     Example: "LHR"
    # @!attribute arrival_airport
    #   @return [String] The IATA code of the arrival airport.
    #     [Optional]
    #     Example: "LAX"
    # @!attribute stop_over_code
    #   @return [String] Whether a stopover is permitted on the leg.
    #     [Optional]
    #     Example: "x"
    # @!attribute fare_basis_code
    #   @return [String] The fare basis code for the leg.
    #     [Optional]
    #     Example: "SPRSVR"
    class FlightLegDetails
      attr_accessor :flight_number,
                    :carrier_code,
                    :class_of_travelling,
                    :departure_date,
                    :departure_time,
                    :departure_airport,
                    :arrival_airport,
                    :stop_over_code,
                    :fare_basis_code
    end
  end
end
