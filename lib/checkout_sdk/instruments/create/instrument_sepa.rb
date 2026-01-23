# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # @!attribute instrument_data
    #   @return [InstrumentData]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class InstrumentSepa < Instrument
      attr_accessor :instrument_data,
                    :account_holder

      def initialize
        super(CheckoutSdk::Common::InstrumentType::SEPA)
      end
    end
  end
end
