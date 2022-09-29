# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute flight_number
    #   @return [Integer]
    # @!attribute carrier_code
    #   @return [String]
    # @!attribute service_class
    #   @return [String]
    # @!attribute departure_date
    #   @return [String]
    # @!attribute departure_time
    #   @return [String]
    # @!attribute departure_airport
    #   @return [String]
    # @!attribute arrival_airport
    #   @return [String]
    # @!attribute stopover_code
    #   @return [String]
    # @!attribute fare_basis_code
    #   @return [String]
    class FlightLegDetails
      attr_accessor :flight_number,
                    :carrier_code,
                    :service_class,
                    :departure_date,
                    :departure_time,
                    :departure_airport,
                    :arrival_airport,
                    :stopover_code,
                    :fare_basis_code
    end
  end
end
