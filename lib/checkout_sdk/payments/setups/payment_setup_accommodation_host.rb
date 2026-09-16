# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Details about the host of the accommodation.
    #
    # @!attribute registration_date
    #   @return [String] The date the host registered. Format: YYYY-MM-DD.
    # @!attribute total_reservation_count
    #   @return [Integer] The total number of reservations the host has received.
    class PaymentSetupAccommodationHost
      attr_accessor :registration_date,
                    :total_reservation_count
    end
  end
end
