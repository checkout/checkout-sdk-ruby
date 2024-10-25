# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute delivery_email
    #   @return [String]
    # @!attribute delivery_timeframe
    #   @return [String] {}DeliveryTimeframe}
    # @!attribute is_preorder
    #   @return [TrueClass, FalseClass]
    # @!attribute is_reorder
    #   @return [TrueClass, FalseClass]
    # @!attribute shipping_indicator
    #   @return [String] {ShippingIndicator}
    # @!attribute reorder_items_indicator
    #   @return [String] {ReorderItemsIndicatorType}
    # @!attribute pre_order_purchase_indicator
    #   @return [String] {PreOrderPurchaseIndicatorType}
    # @!attribute pre_order_date
    #   @return [Time]
    # @!attribute gift_card_amount
    #   @return [String]
    # @!attribute gift_card_currency
    #   @return [String]
    # @!attribute gift_card_count
    #   @return [String]
    class MerchantRiskInfo
      attr_accessor :delivery_email,
                    :delivery_timeframe,
                    :is_preorder,
                    :is_reorder,
                    :shipping_indicator,
                    :reorder_items_indicator,
                    :pre_order_purchase_indicator,
                    :pre_order_date,
                    :gift_card_amount,
                    :gift_card_currency,
                    :gift_card_count
    end
  end
end
