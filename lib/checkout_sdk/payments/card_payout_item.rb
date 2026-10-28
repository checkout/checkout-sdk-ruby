# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A line item of a card payout.
    #
    # @!attribute type
    #   The item type. For example, physical or digital.
    #   This field is used to provide item level metadata where applicable.
    #   [Optional]
    #   Enum: "digital" "physical"
    #   @return [String] {ProductItemType}
    # @!attribute sub_type
    #   The digital item type.
    #   If type is set to digital, this field is required.
    #   [Optional]
    #   Enum: "blockchain" "cbdc" "cryptocurrency" "nft" "stablecoin"
    #   @return [String] {ProductSubType}
    class CardPayoutItem
      attr_accessor :type,
                    :sub_type
    end
  end
end
