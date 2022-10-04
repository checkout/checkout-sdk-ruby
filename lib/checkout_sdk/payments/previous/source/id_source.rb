# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute id
      #   @return [String]
      # @!attribute cvv
      #   @return [String]
      class IdSource < PaymentSource
        attr_accessor :id,
                      :cvv

        def initialize
          super CheckoutSdk::Common::PaymentSourceType::ID
        end
      end
    end
  end
end
