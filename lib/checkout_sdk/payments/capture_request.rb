# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute amount
    #   @return [Integer]
    # @!attribute capture_type
    #   @return [String] {CaptureType}
    # @!attribute reference
    #   @return [String]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest]
    # @!attribute description
    #   @return [String]
    # @!attribute billing_descriptor
    #   @return [BillingDescriptor]
    # @!attribute shipping
    #   @return [ShippingDetails]
    # @!attribute items
    #   @return [Array(Product)]
    # @!attribute marketplace
    #   @deprecated Please use {#amount_allocations} instead
    #   @return [Array(CheckoutSdk::Common::MarketplaceData)]
    # @!attribute amount_allocations
    #   @return [Array(CheckoutSdk::Common::AmountAllocations)]
    # @!attribute processing
    #   @return [ProcessingSettings]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    class CaptureRequest
      attr_accessor :amount,
                    :capture_type,
                    :reference,
                    :customer,
                    :description,
                    :billing_descriptor,
                    :shipping,
                    :items,
                    :marketplace,
                    :amount_allocations,
                    :processing,
                    :metadata
    end
  end
end
