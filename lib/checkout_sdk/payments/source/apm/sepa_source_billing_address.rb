# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The account holder's billing address on a SEPA payment source.
    #
    # Every property is required. This is deliberately not
    # {CheckoutSdk::Common::Address}, which also declares `state` - a property this
    # position does not accept.
    #
    # @!attribute address_line1
    #   @return [String] The account holder's street name. [Required]
    # @!attribute address_line2
    #   @return [String] The account holder's street number. [Required]
    #     max 10 characters.
    # @!attribute city
    #   @return [String] The account holder's city. [Required] max 35 characters.
    # @!attribute zip
    #   @return [String] The account holder's zip code. [Required] max 16 characters.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The account holder's country,
    #     as an ISO 3166-1 alpha-2 code. [Required] max 2 characters.
    class SepaSourceBillingAddress
      attr_accessor :address_line1,
                    :address_line2,
                    :city,
                    :zip,
                    :country
    end
  end
end
