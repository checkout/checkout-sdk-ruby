# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # An entity source, with type entity. Bank payouts only.
    #
    # id: the entity or sub-entity's identifier, only applies to Platform Clients.
    # [Required]
    # ^(ent)_(\w{26})$
    class EntitySource < PayoutSource
      def initialize
        super(PayoutSourceType::ENTITY)
      end
    end
  end
end
