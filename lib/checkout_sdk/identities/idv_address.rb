# frozen_string_literal: true

module CheckoutSdk
  module Identities
    # The applicant's address.
    #
    # @!attribute address_line1
    #   The first line of the address.
    #   [Optional]
    #   max 250 characters
    #   Example: 123 Main Street
    #   @return [String]
    # @!attribute address_line2
    #   The second line of the address.
    #   [Optional]
    #   max 250 characters
    #   Example: Apt 4B
    #   @return [String]
    # @!attribute city
    #   The city or town.
    #   [Optional]
    #   max 50 characters
    #   Example: London
    #   @return [String]
    # @!attribute state
    #   The state, county, or province.
    #   [Optional]
    #   max 50 characters
    #   Example: Greater London
    #   @return [String]
    # @!attribute zip
    #   The postal or ZIP code.
    #   [Optional]
    #   max 50 characters
    #   Example: SW1A 1AA
    #   @return [String]
    # @!attribute country
    #   The two-letter ISO country code of the address.
    #   [Optional]
    #   Standard: ISO 3166-1 alpha-2 country code
    #   max 2 characters
    #   Example: GB
    #   @return [String] a value of {CheckoutSdk::Common::Country}
    class IdvAddress
      attr_accessor :address_line1, :address_line2, :city, :state, :zip, :country
    end
  end
end
