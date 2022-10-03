# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute sub_entity_id
    #   @return [String]
    # @!attribute sub_entities
    #   @return [Array(AmountAllocations)]
    class MarketplaceData
      attr_accessor :sub_entity_id,
                    :sub_entities
    end
  end
end
