# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The billing address of the account holder of a Bacs Direct Debit instrument
    # being stored.
    #
    # @!attribute address_line1
    #   @return [String] The first line of the address. [Optional] max 200 characters.
    # @!attribute address_line2
    #   @return [String] The street number. If no number, pass "w/n".
    #     [Optional] max 10 characters.
    # @!attribute city
    #   @return [String] The address city. [Optional] max 35 characters.
    #     Note the update variant allows max 50.
    # @!attribute zip
    #   @return [String] The address zip/postal code. [Optional] max 16 characters.
    #     Note the update variant allows max 50.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The two-letter ISO country
    #     code of the address. [Required] min 2 characters, max 2 characters.
    class CreateBacsBillingAddress
      attr_accessor :address_line1,
                    :address_line2,
                    :city,
                    :zip,
                    :country
    end
  end
end
