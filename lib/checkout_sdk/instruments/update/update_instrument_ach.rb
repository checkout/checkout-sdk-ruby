# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # Update ACH bank account details.
    #
    # @!attribute instrument_data
    #   @return [UpdateAchInstrumentData] The details of the bank account.
    #     [Optional]
    # @!attribute account_holder
    #   @return [UpdateAchAccountHolder] The account holder details. [Optional]
    class UpdateInstrumentAch < UpdateInstrument
      attr_accessor :instrument_data,
                    :account_holder

      def initialize
        super(CheckoutSdk::Common::InstrumentType::ACH)
      end
    end
  end
end
