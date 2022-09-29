# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute type
    #   @return [String] {DestinationType}
    class Destination
      attr_accessor :type

      protected

      # @abstract
      # @param [String] type {DestinationType}
      def initialize(type)
        @type = type
      end
    end
  end
end
