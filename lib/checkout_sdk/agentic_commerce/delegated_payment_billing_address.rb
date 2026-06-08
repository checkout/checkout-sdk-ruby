# frozen_string_literal: true

module CheckoutSdk
  module AgenticCommerce
    # Billing address required for delegated payments.
    #
    # @!attribute name
    #   @return [String]
    # @!attribute line1
    #   @return [String]
    # @!attribute line2
    #   @return [String]
    # @!attribute city
    #   @return [String]
    # @!attribute state
    #   @return [String]
    # @!attribute postal_code
    #   @return [String]
    # @!attribute country
    #   @return [String] ISO 3166-1 alpha-2
    class DelegatedPaymentBillingAddress
      attr_accessor :name,
                    :line1,
                    :line2,
                    :city,
                    :state,
                    :postal_code,
                    :country
    end
  end
end
