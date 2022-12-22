# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute iban
    #   @return [String]
    # @!attribute swift_bic
    #   @return [String]
    class InstrumentDetailsSepa < InstrumentDetails
      attr_accessor :iban,
                    :swift_bic
    end
  end
end
