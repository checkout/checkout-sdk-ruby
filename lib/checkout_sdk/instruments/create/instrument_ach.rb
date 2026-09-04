# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # Store ACH bank account details.
    #
    # @!attribute instrument_data
    #   @return [CreateAchInstrumentData] The details of the bank account.
    #     [Required]
    # @!attribute account_holder
    #   @return [CreateAchAccountHolder] The account holder details. [Required]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest] The customer's details.
    #     [Optional]
    class InstrumentAch < Instrument
      attr_accessor :instrument_data,
                    :account_holder,
                    :customer

      def initialize
        super(CheckoutSdk::Common::InstrumentType::ACH)
      end
    end
  end
end
