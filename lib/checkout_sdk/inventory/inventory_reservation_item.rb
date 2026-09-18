# frozen_string_literal: true

module CheckoutSdk
  module Inventory
    # A single line item within an inventory reservation. Mirrors swagger
    # `InventoryReservationItem`. Used by {InventoryReservationRequest#items} and present in the
    # `InventoryReservation` response's `items` array (returned as a Hash, not deserialized into
    # this class, per this SDK's response convention).
    #
    # @!attribute variant_id
    #   @return [String] The identifier of the variant to reserve. The variant must already
    #     exist. [Required] max 128 characters.
    # @!attribute quantity
    #   @return [Integer] The quantity to reserve. [Required] min 1.
    class InventoryReservationItem
      attr_accessor :variant_id,
                    :quantity
    end
  end
end
