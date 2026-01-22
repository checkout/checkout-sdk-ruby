# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute name
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::UpdateCustomerRequest]
    class UpdateInstrumentCard < UpdateInstrument
      attr_accessor :expiry_month,
                    :expiry_year,
                    :name,
                    :account_holder,
                    :customer

      def initialize
        super(CheckoutSdk::Common::InstrumentType::CARD)
      end
    end
  end
end
