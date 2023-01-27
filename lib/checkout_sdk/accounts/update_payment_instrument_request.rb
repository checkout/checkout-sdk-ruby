# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute label
    #   @return [String]
    # @!attribute default
    #   @return [TrueClass, FalseClass]
    class UpdatePaymentInstrumentRequest
      attr_accessor :label,
                    :default
    end
  end
end
