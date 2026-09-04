# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The billing address of the account holder of a SEPA instrument being updated.
    #
    # Every property is required if billing_address is sent at all.
    #
    # @!attribute address_line1
    #   @return [String] The first line of the address. [Required] max 200 characters.
    # @!attribute address_line2
    #   @return [String] The street number. If no number, pass "w/n".
    #     [Required] max 10 characters.
    # @!attribute city
    #   @return [String] The address city. [Required] max 50 characters.
    #     Note the store variant allows max 35 only.
    # @!attribute zip
    #   @return [String] The address zip/postal code. [Required] max 50 characters.
    #     Note the store variant allows max 16 only.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The two-letter ISO country
    #     code of the address. [Required] min 2 characters, max 2 characters.
    class UpdateSepaBillingAddress
      attr_accessor :address_line1,
                    :address_line2,
                    :city,
                    :zip,
                    :country
    end
  end
end
