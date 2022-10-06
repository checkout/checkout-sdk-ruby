# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute name
    #   @return [String]
    # @!attribute quantity
    #   @return [Integer]
    # @!attribute price
    #   @return [Integer]
    class Product
      attr_accessor :name,
                    :quantity,
                    :price
    end
  end
end
