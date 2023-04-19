# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute label
    #   @return [String]
    # @!attribute default
    #   @return [TrueClass, FalseClass]
    # @!attribute headers
    #   @return [Headers]
    class UpdatePaymentInstrumentRequest
      attr_accessor :label,
                    :default,
                    :headers
    end
  end
end
