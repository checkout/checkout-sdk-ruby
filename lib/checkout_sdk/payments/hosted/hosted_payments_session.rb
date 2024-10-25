# frozen_string_literal: true

require 'checkout_sdk/payments/payment_type'

module CheckoutSdk
  module Payments
    # @!attribute amount
    #   @return [Integer]
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute payment_type
    #   @return [String] {PaymentType}
    # @!attribute payment_ip
    #   @return [String]
    # @!attribute billing_descriptor
    #   @return [BillingDescriptor]
    # @!attribute reference
    #   @return [String]
    # @!attribute description
    #   @return [String]
    # @!attribute display_name
    #   @return [String]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest]
    # @!attribute shipping
    #   @return [ShippingDetails]
    # @!attribute billing
    #   @return [BillingInformation]
    # @!attribute recipient
    #   @return [PaymentRecipient]
    # @!attribute processing
    #   @return [ProcessingSettings]
    # @!attribute allow_payment_methods
    #   @return [Array(CheckoutSdk::Common::PaymentSourceType)]
    # @!attribute disabled_payment_methods
    #   @return [Array(CheckoutSdk::Common::PaymentSourceType)]
    # @!attribute products
    #   @return [Array(CheckoutSdk::Common::Product)]
    # @!attribute risk
    #   @return [RiskRequest]
    # @!attribute customer_retry
    #   @return [PaymentRetryRequest]
    # @!attribute sender
    #   @return [CheckoutSdk::Payments::Sender]
    # @!attribute success_url
    #   @return [String]
    # @!attribute cancel_url
    #   @return [String]
    # @!attribute failure_url
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash(String=>Object)]
    # @!attribute locale
    #   @return [String]
    # @!attribute three_ds
    #   @return [ThreeDSRequest]
    # @!attribute capture
    #   @return [TrueClass, FalseClass]
    # @!attribute capture_on
    #   @return [Time]
    # @!attribute processing_channel_id
    #   @return [String] - Not available on Previous.
    # @!attribute amount_allocations
    #   @return [Array(CheckoutSdk::Common::AmountAllocations)] - Not available on Previous.
    class HostedPaymentsSession
      attr_accessor :amount,
                    :currency,
                    :payment_ip,
                    :billing_descriptor,
                    :reference,
                    :description,
                    :display_name,
                    :processing_channel_id,
                    :amount_allocations,
                    :customer,
                    :shipping,
                    :billing,
                    :recipient,
                    :processing,
                    :allow_payment_methods,
                    :disabled_payment_methods,
                    :products,
                    :risk,
                    :customer_retry,
                    :sender,
                    :success_url,
                    :cancel_url,
                    :failure_url,
                    :metadata,
                    :locale,
                    :three_ds,
                    :capture,
                    :capture_on

      def initialize(payment_type: CheckoutSdk::Payments::PaymentType::REGULAR)
        @payment_type = payment_type
      end
    end
  end
end
