# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The billing address of the account holder of a SEPA instrument being stored.
    #
    # Every property is required on this shape.
    #
    # @!attribute address_line1
    #   @return [String] The first line of the address. [Required] max 200 characters.
    # @!attribute address_line2
    #   @return [String] The street number. If no number, pass "w/n".
    #     [Required] max 10 characters.
    # @!attribute city
    #   @return [String] The address city. [Required] max 35 characters.
    #     Note the update variant allows max 50.
    # @!attribute zip
    #   @return [String] The address zip/postal code. [Required] max 16 characters.
    #     Note the update variant allows max 50.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The two-letter ISO country
    #     code of the address. [Required] min 2 characters, max 2 characters.
    class CreateSepaBillingAddress
      attr_accessor :address_line1,
                    :address_line2,
                    :city,
                    :zip,
                    :country
    end
  end
end
