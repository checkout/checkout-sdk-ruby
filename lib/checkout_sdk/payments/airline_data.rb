# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute ticket
    #   @return [Ticket]
    # @!attribute passenger
    #   @return [Passenger]
    # @!attribute flight_leg_details
    #   @return [Array(FlightLegDetails)]
    class AirlineData
      attr_accessor :ticket,
                    :passenger,
                    :flight_leg_details
    end
  end
end
