# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Apm
      # @!attribute description
      #   @return [String]
      # @!attribute products
      #   @return [Array(KlarnaProduct)]
      # @!attribute shipping_info
      #   @return [CheckoutSdk::Common::ShippingInfo]
      # @!attribute shipping_delay
      #   @return [Integer]
      class Klarna
        attr_accessor :description,
                      :products,
                      :shipping_info,
                      :shipping_delay
      end
    end
  end
end
