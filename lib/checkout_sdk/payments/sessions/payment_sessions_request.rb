# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute amount
    #   @return [Integer]
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute payment_type
    #   @return [TrueClass, FalseClass]
    # @!attribute billing
    #   @return [BillingInformation]
    # @!attribute billing_descriptor
    #   @return [BillingDescriptor]
    # @!attribute reference
    #   @return [String]
    # @!attribute description
    #   @return [String]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest]
    # @!attribute shipping
    #   @return [ShippingDetails]
    # @!attribute recipient
    #   @return [PaymentRecipient]
    # @!attribute processing
    #   @return [ProcessingSettings]
    # @!attribute processing_channel_id
    #   @return [String]
    # @!attribute expires_on
    #   @return [Time]
    # @!attribute payment_method_configuration
    #   @return [PaymentMethodConfiguration]
    # @!attribute enabled_payment_methods
    #   @return [Array(PaymentMethodsType)]
    # @!attribute disabled_payment_methods
    #   @return [Array(PaymentMethodsType)]
    # @!attribute items
    #   @return [Array(Product)]
    # @!attribute amount_allocations
    #   @return [Array(CheckoutSdk::Common::AmountAllocations)]
    # @!attribute risk
    #   @return [RiskRequest]
    # @!attribute retry
    #   @return [PaymentRetryRequest]
    # @!attribute display_name
    #   @return [String]
    # @!attribute success_url
    #   @return [String]
    # @!attribute failure_url
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    # @!attribute locale
    #   @return [String]
    # @!attribute three_ds
    #   @return [ThreeDSRequest]
    # @!attribute sender
    #   @return [Sender]
    # @!attribute capture
    #   @return [TrueClass, FalseClass]
    # @!attribute ip_address
    #   @return [String]
    # @!attribute capture_on
    #   @return [Time]
    # @!attribute tax_amount
    #   @return [Integer]
    class PaymentSessionsRequest
      attr_accessor :amount,
                    :currency,
                    :payment_type,
                    :billing,
                    :billing_descriptor,
                    :reference,
                    :description,
                    :customer,
                    :shipping,
                    :recipient,
                    :processing,
                    :processing_channel_id,
                    :expires_on,
                    :payment_method_configuration,
                    :enabled_payment_methods,
                    :disabled_payment_methods,
                    :items,
                    :amount_allocations,
                    :risk,
                    :retry,
                    :display_name,
                    :success_url,
                    :failure_url,
                    :metadata,
                    :locale,
                    :three_ds,
                    :sender,
                    :capture,
                    :ip_address,
                    :capture_on,
                    :tax_amount
    end
  end
end
