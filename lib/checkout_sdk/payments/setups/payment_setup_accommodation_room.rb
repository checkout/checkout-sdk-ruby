# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A room booked by the customer.
    #
    # @!attribute rate
    #   @return [Float] The nightly rate of the room.
    # @!attribute number_of_nights
    #   @return [Integer] The number of nights booked for the room.
    # @!attribute type
    #   @return [String] The type of room, for example "deluxe".
    class PaymentSetupAccommodationRoom
      attr_accessor :rate,
                    :number_of_nights,
                    :type
    end
  end
end
