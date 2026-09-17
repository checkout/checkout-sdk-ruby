# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Details about an airline booking.
    #
    # @!attribute ticket
    #   @return [PaymentSetupAirlineTicket] Details about the airline ticket.
    # @!attribute passengers
    #   @return [Array(PaymentSetupAirlinePassenger)] The list of passengers on the flight.
    # @!attribute flight_leg_details
    #   @return [Array(FlightLegDetails)] The list of flight legs booked by the customer.
    # @!attribute total_number_of_passengers
    #   @return [Integer] The total number of passengers on the booking.
    # @!attribute travel_type
    #   @return [String] The type of travel, for example "international" or "domestic".
    # @!attribute trip_type
    #   @return [String] The type of trip, for example "one_way" or "round_trip".
    # @!attribute refundable
    #   @return [Boolean] Specifies whether the booking is refundable.
    # @!attribute delivery_recipient
    #   @return [String] The recipient the ticket is delivered to.
    # @!attribute ancillaries
    #   @return [String] Any additional add-ons purchased with the booking, for example
    #     "extra_baggage".
    # @!attribute insurance
    #   @return [PaymentSetupAirlineInsurance] Details about the travel insurance purchased with
    #     the booking.
    class PaymentSetupAirline
      attr_accessor :ticket,
                    :passengers,
                    :flight_leg_details,
                    :total_number_of_passengers,
                    :travel_type,
                    :trip_type,
                    :refundable,
                    :delivery_recipient,
                    :ancillaries,
                    :insurance
    end
  end
end
