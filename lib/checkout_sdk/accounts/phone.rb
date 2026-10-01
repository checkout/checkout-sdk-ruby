# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # A phone number on the Accounts API: the sub-entity's contact phone, or a representative's phone. See
    # {ContactDetails#phone} for the per-variant number format.
    # @!attribute country_code
    #   The ISO 3166-1 alpha-2 country where the number is registered, not the dialling code.
    #   [Required] on Accounts API v3.0; not part of the v2.0 schemas.
    #   @return [String]
    # @!attribute number
    #   The phone number, without the country calling code.
    #   [Required]
    #   @return [String]
    class Phone
      attr_accessor :country_code,
                    :number
    end
  end
end
