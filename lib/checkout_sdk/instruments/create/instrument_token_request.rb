# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # @!attribute token
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest]
    class InstrumentTokenRequest < InstrumentRequest
      attr_accessor :token,
                    :account_holder,
                    :customer

      def initialize
        super CheckoutSdk::Common::InstrumentType::TOKEN
      end
    end
  end
end
