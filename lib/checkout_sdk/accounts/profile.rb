# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Information about the profile of the sub-entity, primarily regarding the products and services
    # offered.
    # @!attribute urls
    #   A collection of website URLs the sub-entity accepts payments on.
    #   [Required]
    #   max 100 items; each ^(http|https):\/\/\S{2,293}$, Format: uri
    #   @return [Array(String)]
    # @!attribute mccs
    #   The merchant category codes (4-digit ISO 18245) that most closely describe the business.
    #   [Required]
    #   min 1 item, max 5 items; each ^[0-9]{4}$
    #   @return [Array(String)]
    # @!attribute default_holding_currency
    #   The default holding currency (ISO 4217).
    #   [Required] on every v3.0 variant; [Optional] on the v2.0 variants.
    #   Format: iso-4217
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute holding_currencies
    #   The currencies incoming funds are held in.
    #   [Required] on every v3.0 variant; [Optional] on the v2.0 variants.
    #   min 1 item on v3.0; USD only on the US variants
    #   @return [Array(CheckoutSdk::Common::Currency)]
    class Profile
      attr_accessor :urls,
                    :mccs,
                    :default_holding_currency,
                    :holding_currencies
    end
  end
end
