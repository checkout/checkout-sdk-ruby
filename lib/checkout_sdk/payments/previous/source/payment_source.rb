# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute type
      #   @return [String] {CheckoutSdk::Common::PaymentSourceType}
      class PaymentSource
        attr_reader :type

        protected

        # @param [String] type {CheckoutSdk::Common::PaymentSourceType}
        def initialize(type)
          @type = type
        end
      end
    end
  end
end
