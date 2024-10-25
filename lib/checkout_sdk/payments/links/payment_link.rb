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
    # @!attribute processing_channel_id
    #   @return [String] - Not available on Previous.
    # @!attribute amount_allocations
    #   @return [Array(CheckoutSdk::Common::AmountAllocations)] - Not available on Previous.
    # @!attribute expires_in
    #   @return [Integer]
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
    # @!attribute metadata
    #   @return [Hash(String=>Object)]
    # @!attribute three_ds
    #   @return [ThreeDSRequest]
    # @!attribute risk
    #   @return [RiskRequest]
    # @!attribute customer_retry
    #   @return [CheckoutSdk::Common::CustomerRetry]
    # @!attribute sender
    #   @return [CheckoutSdk::Payments::Sender]
    # @!attribute return_url
    #   @return [String]
    # @!attribute locale
    #   @return [String]
    # @!attribute capture
    #   @return [TrueClass, FalseClass]
    # @!attribute capture_on
    #   @return [Time]
    class PaymentLink
      attr_accessor :amount,
                    :currency,
                    :payment_type,
                    :payment_ip,
                    :billing_descriptor,
                    :reference,
                    :description,
                    :display_name,
                    :processing_channel_id,
                    :amount_allocations,
                    :expires_in,
                    :customer,
                    :shipping,
                    :billing,
                    :recipient,
                    :processing,
                    :allow_payment_methods,
                    :disabled_payment_methods,
                    :products,
                    :metadata,
                    :three_ds,
                    :risk,
                    :customer_retry,
                    :sender,
                    :return_url,
                    :locale,
                    :capture,
                    :capture_on

      def initialize(payment_type: CheckoutSdk::Payments::PaymentType::REGULAR)
        @payment_type = payment_type
      end
    end
  end
end
