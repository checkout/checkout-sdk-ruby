# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # @!attribute type
    #   @return [String] {CheckoutSdk::Common::InstrumentType}
    class InstrumentRequest
      attr_reader :type

      # @abstract
      # @param [String]  {CheckoutSdk::Common::InstrumentType}
      def initialize(type)
        @type = type
      end
    end
  end
end
