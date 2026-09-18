# frozen_string_literal: true

module CheckoutSdk
  module Inventory
    # Request body for POST /inventory/adjustments. Mirrors swagger
    # `InventoryAdjustmentRequest`.
    #
    # @!attribute variant_id
    #   @return [String] The identifier of the variant to adjust. The variant must already
    #     exist. [Required] max 128 characters.
    # @!attribute delta
    #   @return [Integer] The signed change to apply to on_hand. A negative delta that would
    #     drive on_hand below zero is rejected with a 409. Per spec, must be non-zero (not a
    #     formal schema constraint). [Required]
    # @!attribute reason
    #   @return [String] A free-text reason recorded in the ledger. Must not contain personal
    #     data. [Required] min 1 character, max 256 characters.
    class InventoryAdjustmentRequest
      attr_accessor :variant_id,
                    :delta,
                    :reason
    end
  end
end
