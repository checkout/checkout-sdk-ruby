# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute product_id
    #   @return [String]
    # @!attribute quantity
    #   @return [Integer]
    # @!attribute price
    #   @return [Integer]
    # @!attribute description
    #   @return [String]
    class FawryProduct
      attr_accessor :product_id,
                    :quantity,
                    :price,
                    :description
    end
  end
end
