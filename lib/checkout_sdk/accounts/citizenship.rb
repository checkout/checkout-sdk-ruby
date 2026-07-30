# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # A citizenship or legal status held by a company representative (Accounts API v3.0).
    # @!attribute type
    #   @return [String] The type of citizenship or legal status (e.g. `citizenship`, `residency`).
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} two-letter ISO 3166-1 alpha-2 code.
    class Citizenship
      attr_accessor :type,
                    :country
    end
  end
end
