# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # Update SEPA account details.
    #
    # @!attribute instrument_data
    #   @return [UpdateSepaInstrumentData] The details of the mandate. [Optional]
    # @!attribute account_holder
    #   @return [UpdateSepaAccountHolder] The account holder details. [Optional]
    class UpdateInstrumentSepa < UpdateInstrument
      attr_accessor :instrument_data,
                    :account_holder

      def initialize
        super(CheckoutSdk::Common::InstrumentType::SEPA)
      end
    end
  end
end
