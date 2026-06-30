# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Address block used in Issuing requests (billing/residency on cardholders).
    # Matches swagger `IssuingAddress`. `address_line1`, `city`, `zip`, `country`
    # are required per spec; other fields are optional.
    #
    # @!attribute address_line1
    #   @return [String] [Required]
    # @!attribute address_line2
    #   @return [String]
    # @!attribute city
    #   @return [String] [Required]
    # @!attribute state
    #   @return [String]
    # @!attribute zip
    #   @return [String] [Required]
    # @!attribute country
    #   @return [String] ISO-3166 alpha-2 country code. [Required]
    class IssuingAddress
      attr_accessor :address_line1, :address_line2, :city, :state, :zip, :country
    end
  end
end
