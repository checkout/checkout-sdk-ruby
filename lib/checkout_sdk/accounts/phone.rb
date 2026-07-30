# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute country_code
    #   @return [String] ISO 3166-1 alpha-2 country code (Accounts API v3.0), e.g. "GB".
    # @!attribute number
    #   @return [String]
    class Phone
      attr_accessor :country_code,
                    :number
    end
  end
end
