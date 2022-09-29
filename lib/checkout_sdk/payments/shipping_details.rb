# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute phone
    #   @return [CheckoutSdk::Common::Phone]
    # @!attribute from_address_zip
    #   @return [String]
    class ShippingDetails
      attr_accessor :address,
                    :phone,
                    :from_address_zip
    end
  end
end
