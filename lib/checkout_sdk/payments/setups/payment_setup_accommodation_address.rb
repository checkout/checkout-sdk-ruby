# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The accommodation's address.
    #
    # @!attribute address_line1
    #   @return [String] The first line of the address.
    # @!attribute city
    #   @return [String] The city of the address.
    # @!attribute state
    #   @return [String] The state of the address.
    # @!attribute country
    #   @return [String] The country of the address, as an ISO 3166-1 alpha-2 country code.
    # @!attribute zip
    #   @return [String] The postal/zip code of the address.
    class PaymentSetupAccommodationAddress
      attr_accessor :address_line1,
                    :city,
                    :state,
                    :country,
                    :zip
    end
  end
end
