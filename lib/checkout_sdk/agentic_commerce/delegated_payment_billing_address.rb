# frozen_string_literal: true

module CheckoutSdk
  module AgenticCommerce
    # Billing address required for delegated payments. Mirrors swagger
    # `DelegatedPaymentBillingAddress`. Required: `name`, `line_one`, `city`,
    # `postal_code`, `country`.
    #
    # @!attribute name
    #   @return [String] Full customer name. [Required]
    # @!attribute line_one
    #   @return [String] First line of the street address. [Required]
    # @!attribute line_two
    #   @return [String] Second line of the street address.
    # @!attribute city
    #   @return [String] [Required]
    # @!attribute state
    #   @return [String] State / region.
    # @!attribute postal_code
    #   @return [String] Postal/ZIP code. [Required]
    # @!attribute country
    #   @return [String] ISO 3166-1 alpha-2. [Required]
    class DelegatedPaymentBillingAddress
      attr_accessor :name,
                    :line_one,
                    :line_two,
                    :city,
                    :state,
                    :postal_code,
                    :country
    end
  end
end
