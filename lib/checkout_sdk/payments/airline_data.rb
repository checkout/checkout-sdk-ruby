# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Contains information about the airline ticket and flights booked by the customer.
    #
    # Maps the swagger `AirlineData` schema, which `POST /payments`, the `GET /payments/{id}`
    # response and `PaymentContextProcessing` all resolve to, and the
    # `PaymentInterfacesProcessingAirlineData` schema used by hosted payments, payment links and
    # payment sessions. The two declare the same three properties.
    #
    # @!attribute ticket
    #   @return [Ticket] Contains information about the airline ticket.
    #     [Optional]
    #     A single object, not a collection.
    # @!attribute passenger
    #   @return [Passenger, Array(Passenger)] Contains information about the passenger or
    #     passengers on the flight.
    #     [Optional]
    #
    #     Accepts either a single {Passenger} or an array of them, and the choice is not
    #     cosmetic. Verified against the sandbox on 2026-09-25:
    #
    #       | Surface                  | object | array |
    #       |--------------------------|--------|-------|
    #       | POST /payments           | 201    | 201   |
    #       | POST /hosted-payments    | 201    | 422   |
    #       | POST /payment-links      | 201    | 422   |
    #       | POST /payment-contexts   | 201    | 422   |
    #
    #     So assign a single {Passenger} for one passenger: that is accepted on every request
    #     surface. Assign an array only for two or more, and only on `POST /payments`, which is
    #     the sole surface that takes it. Leave the attribute unset when there are no passengers:
    #     an empty array and an explicit null are both rejected with
    #     `processing_airline_data_0_passenger_invalid`.
    #
    #     This inverts the specification, which declares the property array-only on `AirlineData`
    #     and `oneOf[array, object]` on `PaymentInterfacesProcessingAirlineData`. The array branch
    #     does not exist in practice on three of the four surfaces. Responses may carry either
    #     shape, so read defensively.
    # @!attribute flight_leg_details
    #   @return [Array(FlightLegDetails)] Contains information about the flight legs booked by the
    #     customer.
    #     [Optional]
    class AirlineData
      attr_accessor :ticket,
                    :passenger,
                    :flight_leg_details
    end
  end
end
