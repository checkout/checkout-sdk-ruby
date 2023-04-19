# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute label
    #   @return [String]
    # @!attribute type
    #   @return [String] {CheckoutSdk::Common::InstrumentType}
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute default
    #   @return [TrueClass, FalseClass]
    # @!attribute document
    #   @return [InstrumentDocument]
    # @!attribute instrument_details
    #   @return [InstrumentDetails]
    class PaymentInstrumentRequest
      attr_accessor :label,
                    :type,
                    :currency,
                    :country,
                    :default,
                    :document,
                    :instrument_details
    end
  end
end
