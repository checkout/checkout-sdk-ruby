# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Details about an accommodation booking (lodging or cruise).
    #
    # @!attribute name
    #   @return [String] For lodging, the lodging name that appears on the storefront/customer
    #     receipts. For cruise, the ship name booked for the cruise.
    # @!attribute booking_reference
    #   @return [String] A unique identifier for the booking.
    # @!attribute check_in_date
    #   @return [String] For lodging bookings, the customer's check-in date. For cruise bookings,
    #     the cruise departure date (sail date). Format: YYYY-MM-DD.
    # @!attribute check_out_date
    #   @return [String] For lodging bookings, the customer's check-out date. For cruise bookings,
    #     the cruise return date. Format: YYYY-MM-DD.
    # @!attribute address
    #   @return [PaymentSetupAccommodationAddress] The accommodation's address.
    # @!attribute number_of_rooms
    #   @return [Integer] The total number of rooms booked for the accommodation.
    # @!attribute guests
    #   @return [Array(PaymentSetupAccommodationGuest)] The list of guests staying at the
    #     accommodation.
    # @!attribute room
    #   @return [Array(PaymentSetupAccommodationRoom)] The list of rooms booked by the customer.
    # @!attribute total_number_of_guests
    #   @return [Integer] The total number of guests on the booking.
    # @!attribute refundable
    #   @return [Boolean] Specifies whether the booking is refundable.
    # @!attribute delivery_recipient
    #   @return [String] The recipient the booking confirmation is delivered to.
    # @!attribute host
    #   @return [PaymentSetupAccommodationHost] Details about the host of the accommodation.
    class PaymentSetupAccommodation
      attr_accessor :name,
                    :booking_reference,
                    :check_in_date,
                    :check_out_date,
                    :address,
                    :number_of_rooms,
                    :guests,
                    :room,
                    :total_number_of_guests,
                    :refundable,
                    :delivery_recipient,
                    :host
    end
  end
end
