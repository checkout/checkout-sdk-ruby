# frozen_string_literal: true

module CheckoutSdk
  module Inventory
    # Request body for POST /inventory/reservations. Mirrors swagger
    # `InventoryReservationRequest`.
    #
    # @!attribute owner_type
    #   @return [String] Free-text classification of the reservation's owner (e.g. an agent or
    #     order type). [Required] max 64 characters.
    # @!attribute owner_reference
    #   @return [String] A reference identifying the specific owner, echoed back on the
    #     reservation. [Required] max 256 characters.
    # @!attribute items
    #   @return [Array<InventoryReservationItem>] The variants and quantities to hold.
    #     [Required] min 1 item, max 45 items. variant_id must be unique within the request.
    # @!attribute ttl_seconds
    #   @return [Integer] How long the hold stays active before it expires. [Optional]
    #     min 60, max 3600. Default: 900.
    class InventoryReservationRequest
      attr_accessor :owner_type,
                    :owner_reference,
                    :items,
                    :ttl_seconds
    end
  end
end
