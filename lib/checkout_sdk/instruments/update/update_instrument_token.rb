# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # @!attribute token
    #   @return [String]
    class UpdateInstrumentToken < UpdateInstrument
      attr_accessor :token

      def initialize
        super CheckoutSdk::Common::InstrumentType::TOKEN
      end
    end
  end
end
