# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute name
    #   @return [String]
    # @!attribute quantity
    #   @return [Integer]
    # @!attribute price
    #   @return [Integer]
    # @!attribute reference
    #   @return [String]
    class Product
      attr_accessor :name,
                    :quantity,
                    :price,
                    :reference
    end
  end
end
