# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class EntitySource < PayoutSource
      def initialize
        super(PayoutSourceType::ENTITY)
      end
    end
  end
end
