# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Contains information about the airline ticket.
    #
    # Maps the inline `ticket` object on the swagger `AirlineData` and
    # `PaymentInterfacesProcessingAirlineData` schemas. Both declare the same six properties.
    #
    # @!attribute number
    #   @return [String] The ticket's unique identifier.
    #     [Optional]
    #     Example: "045-21351455613"
    # @!attribute issue_date
    #   @return [String] Date the airline ticket was issued.
    #     [Optional]
    #     Format: date (YYYY-MM-DD)
    #     Example: "2023-05-20"
    # @!attribute issuing_carrier_code
    #   @return [String] Carrier code of the ticket issuer.
    #     [Optional]
    #     Example: "AI"
    # @!attribute travel_package_indicator
    #   @return [String] C = Car rental reservation, A = Airline flight reservation,
    #     B = Both car rental and airline flight reservations included, N = Unknown.
    #     [Optional]
    #     Example: "B"
    # @!attribute travel_agency_name
    #   @return [String] The name of the travel agency.
    #     [Optional]
    #     Example: "World Tours"
    # @!attribute travel_agency_code
    #   @return [String] The unique identifier from IATA or ARC for the travel agency that
    #     issues the ticket.
    #     [Optional]
    #     Example: "01"
    class Ticket
      attr_accessor :number,
                    :issue_date,
                    :issuing_carrier_code,
                    :travel_package_indicator,
                    :travel_agency_name,
                    :travel_agency_code
    end
  end
end
