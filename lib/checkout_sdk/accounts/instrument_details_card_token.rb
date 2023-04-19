# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute token
    #   @return [String]
    class InstrumentDetailsCardToken < InstrumentDetails
      attr_accessor :token
    end
  end
end
