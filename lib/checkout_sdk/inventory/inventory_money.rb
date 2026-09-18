# frozen_string_literal: true

module CheckoutSdk
  module Inventory
    # A monetary amount in an inventory product's price or sale_price. Mirrors swagger
    # `InventoryMoney`. Used by {InventorySetProductRequest#price} and
    # {InventorySetProductRequest#sale_price}.
    #
    # @!attribute amount
    #   @return [Integer] The amount in the currency's minor unit. [Required]
    # @!attribute currency
    #   @return [String] The 3-letter ISO 4217 currency code. [Required] min 3 characters,
    #     max 3 characters.
    class InventoryMoney
      attr_accessor :amount,
                    :currency
    end
  end
end
