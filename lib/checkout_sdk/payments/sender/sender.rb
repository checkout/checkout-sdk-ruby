# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute type
    #   @return [String] {SenderType}
    # @!attribute reference
    #   @return [String]
    class Sender
      attr_reader :type
      attr_accessor :reference

      protected

      # @abstract
      # @param [String] type {SenderType}
      def initialize(type)
        @type = type
      end
    end
  end
end
