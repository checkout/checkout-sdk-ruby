# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The place of birth of the person.
    # @!attribute country
    #   The country code (iso-3166-1 alpha-2).
    #   [Required]
    #   Format: iso-3166-1-alpha-2
    #   @return [String] {CheckoutSdk::Common::Country}
    class PlaceOfBirth
      attr_accessor :country
    end
  end
end
