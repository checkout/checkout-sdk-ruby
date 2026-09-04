# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # Store Bacs Direct Debit account details.
    #
    # @!attribute account
    #   @return [CreateBacsInstrumentAccount] The account configuration for the
    #     instrument. [Required]
    # @!attribute instrument_data
    #   @return [CreateBacsInstrumentData] The details of the Bacs Direct Debit
    #     account. [Required]
    # @!attribute account_holder
    #   @return [CreateBacsAccountHolder] The account holder details. [Required]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest] The customer's details.
    #     [Optional]
    class InstrumentBacs < Instrument
      attr_accessor :account,
                    :instrument_data,
                    :account_holder,
                    :customer

      def initialize
        super(CheckoutSdk::Common::InstrumentType::BACS)
      end
    end
  end
end
