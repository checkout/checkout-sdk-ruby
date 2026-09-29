# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Contains information about the accommodation booked by the customer.
    #
    # Maps the swagger `AccommodationData` schema, which `POST /payments`, the
    # `GET /payments/{id}` response and `PaymentContextProcessing` all resolve to.
    #
    # `property_phone` and `customer_service_phone` are declared on `AccommodationData` only.
    # The `PaymentInterfacesProcessingAccommodationData` schema used by hosted payments, payment
    # links and payment sessions carries the other eleven properties but neither phone array, so
    # those two are read on `POST /payments` and payment contexts and ignored elsewhere.
    #
    # @!attribute name
    #   @return [String] The name of the accommodation.
    #     [Optional]
    #     Example: "The Sea View Hotel"
    # @!attribute booking_reference
    #   @return [String] The booking reference for the stay.
    #     [Optional]
    #     Example: "HOTEL123"
    # @!attribute check_in_date
    #   @return [String] The date the customer checks in.
    #     [Optional]
    #     Format: date (YYYY-MM-DD)
    #     Example: "2023-06-20"
    # @!attribute check_out_date
    #   @return [String] The date the customer checks out.
    #     [Optional]
    #     Format: date (YYYY-MM-DD)
    #     Example: "2023-06-23"
    # @!attribute address
    #   @return [AccommodationAddress] The address of the accommodation.
    #     [Optional]
    # @!attribute state
    #   @return [String] The state or region the accommodation is in.
    #     [Optional]
    #     A plain string, not a country code. Example: "FL"
    # @!attribute country
    #   @return [String] The country the accommodation is in.
    #     [Optional]
    #     A plain string, not an ISO 3166-1 alpha-2 code: the specification's own example is the
    #     three-letter "USA", which no alpha-2 enum can hold. Example: "USA"
    # @!attribute city
    #   @return [String] The city the accommodation is in.
    #     [Optional]
    #     Example: "Los Angeles"
    # @!attribute number_of_rooms
    #   @return [Integer] The number of rooms booked.
    #     [Optional]
    #     Example: 2
    # @!attribute guests
    #   @return [Array(AccommodationGuest)] The guests staying at the accommodation.
    #     [Optional]
    # @!attribute room
    #   @return [Array(AccommodationRoom)] The rooms booked by the customer.
    #     [Optional]
    #     Named `room` in the singular by the specification, and it is an array.
    # @!attribute property_phone
    #   @return [Array(AccommodationPhone)] Phone numbers for the property.
    #     [Optional]
    #     Declared on `AccommodationData` only.
    # @!attribute customer_service_phone
    #   @return [Array(AccommodationPhone)] Customer service phone numbers for the property.
    #     [Optional]
    #     Declared on `AccommodationData` only.
    class AccommodationData
      attr_accessor :name,
                    :booking_reference,
                    :check_in_date,
                    :check_out_date,
                    :address,
                    :state,
                    :country,
                    :city,
                    :number_of_rooms,
                    :guests,
                    :room,
                    :property_phone,
                    :customer_service_phone
    end

    # Partial address information for an accommodation.
    #
    # The specification declares exactly these two properties, so this is deliberately not the
    # wide {CheckoutSdk::Common::Address}.
    #
    # @!attribute address_line1
    #   @return [String] The first line of the address.
    #     [Optional]
    #     Example: "123 Beach Road"
    # @!attribute zip
    #   @return [String] The postal code of the address.
    #     [Optional]
    #     Example: "10001"
    class AccommodationAddress
      attr_accessor :address_line1,
                    :zip
    end

    # A guest staying at the accommodation.
    #
    # @!attribute first_name
    #   @return [String] The guest's first name.
    #     [Optional]
    #     Example: "Jane"
    # @!attribute last_name
    #   @return [String] The guest's last name.
    #     [Optional]
    #     Example: "Doe"
    # @!attribute date_of_birth
    #   @return [String] The guest's date of birth.
    #     [Optional]
    #     Format: date (YYYY-MM-DD)
    #     Example: "1985-07-14"
    class AccommodationGuest
      attr_accessor :first_name,
                    :last_name,
                    :date_of_birth
    end

    # A room booked at the accommodation.
    #
    # Both properties are strings in this schema. The payment setups equivalent,
    # {PaymentSetupAccommodationRoom}, declares a numeric `rate` and an integer
    # `number_of_nights` instead, so the two are not interchangeable.
    #
    # @!attribute rate
    #   @return [String] The nightly rate for the room.
    #     [Optional]
    #     A string, not a number. Example: "70"
    # @!attribute number_of_nights_at_room_rate
    #   @return [String] The number of nights booked at that rate.
    #     [Optional]
    #     A string, not an integer. Example: "3"
    class AccommodationRoom
      attr_accessor :rate,
                    :number_of_nights_at_room_rate
    end

    # A phone number for an accommodation property.
    #
    # The specification declares exactly these two properties, so this is deliberately not the
    # wide {CheckoutSdk::Common::Phone}.
    #
    # @!attribute country_code
    #   @return [String] The international dialling code.
    #     [Optional]
    #     Example: "44"
    # @!attribute number
    #   @return [String] The phone number.
    #     [Optional]
    #     Example: "7123456789"
    class AccommodationPhone
      attr_accessor :country_code,
                    :number
    end
  end
end
