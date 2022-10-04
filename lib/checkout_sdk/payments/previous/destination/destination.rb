# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute type
      #   @return [String] {CheckoutSdk::Payments::DestinationType}
      class Destination
        attr_reader :type

        protected

        # @abstract
        # @param [String] type {CheckoutSdk::Payments::DestinationType}
        def initialize(type)
          @type = type
        end
      end
    end
  end
end
