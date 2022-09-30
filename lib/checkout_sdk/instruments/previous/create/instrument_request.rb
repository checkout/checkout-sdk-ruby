# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Instruments
      # @!attribute type
      #   @return [String] {CheckoutSdk::Common::InstrumentType}
      # @!attribute token
      #   @return [String]
      # @!attribute account_holder
      #   @return [CheckoutSdk::Common::AccountHolder]
      # @!attribute customer
      #   @return [CheckoutSdk::Common::CustomerRequest]
      class InstrumentRequest
        attr_accessor :type,
                      :token,
                      :account_holder,
                      :customer

        def initialize
          @type = CheckoutSdk::Common::InstrumentType::TOKEN
        end
      end
    end
  end
end
