# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # Update Bacs Direct Debit account details.
    #
    # @!attribute instrument_data
    #   @return [UpdateBacsInstrumentData] The details of the Bacs Direct Debit
    #     account. [Optional]
    # @!attribute account_holder
    #   @return [UpdateBacsAccountHolder] The account holder details. [Optional]
    class UpdateInstrumentBacs < UpdateInstrument
      attr_accessor :instrument_data,
                    :account_holder

      def initialize
        super(CheckoutSdk::Common::InstrumentType::BACS)
      end
    end
  end
end
