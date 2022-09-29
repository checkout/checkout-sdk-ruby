# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute delivery_email
    #   @return [String]
    # @!attribute delivery_timeframe
    #   @return [String] {DeliveryTimeframe}
    # @!attribute is_preorder
    #   @return [TrueClass, FalseClass]
    # @!attribute is_reorder
    #   @return [TrueClass, FalseClass]
    # @!attribute shipping_indicator
    #   @return [String] {ShippingIndicator}
    class MerchantRiskInfo
      attr_accessor :delivery_email,
                    :delivery_timeframe,
                    :is_preorder,
                    :is_reorder,
                    :shipping_indicator
    end
  end
end
