# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute address_line1
    #   @return [String]
    # @!attribute address_line2
    #   @return [String]
    # @!attribute city
    #   @return [String]
    # @!attribute state
    #   @return [String]
    # @!attribute zip
    #   @return [String]
    # @!attribute country
    #   @return [String]
    class Address
      attr_accessor :address_line1,
                    :address_line2,
                    :city,
                    :state,
                    :zip,
                    :country
    end
  end
end
