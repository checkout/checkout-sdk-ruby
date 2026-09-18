# frozen_string_literal: true

module CheckoutSdk
  module Inventory
    # Request body for PUT /inventory/{variant_id}. Mirrors swagger
    # `InventorySetLevelsRequest`.
    #
    # @!attribute on_hand
    #   @return [Integer] The physical stock to set for the variant. [Required] min 0.
    # @!attribute safety_stock
    #   @return [Integer] The buffer withheld from sale. [Optional] min 0. Defaults to 0 on
    #     create; left unchanged on update if omitted.
    # @!attribute reason
    #   @return [String] A free-text reason recorded in the ledger. Must not contain personal
    #     data. [Optional] max 256 characters.
    class InventorySetLevelsRequest
      attr_accessor :on_hand,
                    :safety_stock,
                    :reason
    end
  end
end
