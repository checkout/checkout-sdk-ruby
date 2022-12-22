# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute account_number
    #   @return [String]
    # @!attribute bank_code
    #   @return [String]
    class InstrumentDetailsFasterPayments < InstrumentDetails
      attr_accessor :account_number,
                    :bank_code
    end
  end
end
