# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Details about the airline ticket.
    #
    # @!attribute number
    #   @return [String] The ticket number.
    # @!attribute issue_date
    #   @return [String] The date the ticket was issued. Format: YYYY-MM-DD.
    # @!attribute issuing_carrier_code
    #   @return [String] The code of the carrier that issued the ticket.
    # @!attribute travel_package_indicator
    #   @return [String] Indicates whether the ticket is part of a travel package.
    # @!attribute travel_agency_name
    #   @return [String] The name of the travel agency that issued the ticket.
    # @!attribute travel_agency_code
    #   @return [String] The code of the travel agency that issued the ticket.
    class PaymentSetupAirlineTicket
      attr_accessor :number,
                    :issue_date,
                    :issuing_carrier_code,
                    :travel_package_indicator,
                    :travel_agency_name,
                    :travel_agency_code
    end
  end
end
