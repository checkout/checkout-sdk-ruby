# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # A citizenship or legal-status record of a representative (US ISV Seller variants).
    # @!attribute type
    #   The type of citizenship or legal status (for example citizenship or residency).
    #   [Optional]
    #   @return [String] The type of citizenship or legal status (e.g. `citizenship`, `residency`).
    # @!attribute country
    #   The two-letter ISO 3166-1 alpha-2 country code.
    #   [Required]
    #   Format: iso-3166-1-alpha-2
    #   @return [String] {CheckoutSdk::Common::Country} two-letter ISO 3166-1 alpha-2 code.
    class Citizenship
      attr_accessor :type,
                    :country
    end
  end
end
