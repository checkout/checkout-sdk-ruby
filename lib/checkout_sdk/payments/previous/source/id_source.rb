# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute id
      #   @return [String]
      # @!attribute cvv
      #   @return [String]
      # @!attribute stored
      #   @return [TrueClass, FalseClass]
      # @!attribute store_for_future_use
      #   @return [TrueClass, FalseClass]
      class IdSource < PaymentSource
        attr_accessor :id,
                      :cvv,
                      :stored,
                      :store_for_future_use

        def initialize
          super(CheckoutSdk::Common::PaymentSourceType::ID)
        end
      end
    end
  end
end
