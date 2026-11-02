# frozen_string_literal: true

require 'checkout_sdk/payments/payment_type'

module CheckoutSdk
  module Payments
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency} [Required] The three-letter ISO currency code of the payment
    # @!attribute billing
    #   @return [BillingInformation] [Required] The billing details
    # @!attribute success_url
    #   @return [String] [Required] For redirect payment methods, this overrides the default success redirect URL
    #     configured on your account
    # @!attribute cancel_url
    #   @return [String] [Required] The URL to which the customer should be directed if they cancel the payment
    # @!attribute failure_url
    #   @return [String] [Required] For redirect payment methods, this overrides the default failure redirect URL
    #     configured on your account
    # @!attribute amount
    #   @return [Integer] [Optional] The payment amount. Minimum 0.
    # @!attribute payment_type
    #   @return [String] {PaymentType} [Optional] This must be specified for card payments where the cardholder is not
    #     present (i.e., recurring or mail order / telephone order)
    # @!attribute payment_ip
    #   @return [String] [Optional] The Customers IP address. Only IPv4 and IPv6 addresses are accepted.
    #   @deprecated The Customers IP address is deprecated in the API reference. Will be removed in the next
    #     major version.
    # @!attribute billing_descriptor
    #   @return [BillingDescriptor] [Optional] An optional description that is displayed on the customer's statement
    #     identifying a purchase
    # @!attribute reference
    #   @return [String] [Optional] A reference you can use to identify the payment.
    # @!attribute description
    #   @return [String] [Optional] A description of the payment
    # @!attribute display_name
    #   @return [String] [Optional] The merchant name to display to customers on the checkout page.
    # @!attribute processing_channel_id
    #   @return [String] [Optional] The processing channel to be used for the payment
    # @!attribute amount_allocations
    #   @return [Array(CheckoutSdk::Common::AmountAllocations)] [Optional] The sub-entities that the payment is being
    #     processed on behalf of
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest] [Optional] The customer's details
    # @!attribute shipping
    #   @return [ShippingDetails] [Optional] The address any products are being sent to.
    # @!attribute recipient
    #   @return [PaymentRecipient] [Optional] Information about the recipient of the payment's funds.
    # @!attribute processing
    #   @return [ProcessingSettings] [Optional] Use the processing object to influence or override the data sent
    #     during card processing
    # @!attribute allow_payment_methods
    #   @return [Array(CheckoutSdk::Common::PaymentSourceType)] [Optional] Specifies which payment method options to
    #     present to the customer.
    # @!attribute disabled_payment_methods
    #   @return [Array(CheckoutSdk::Common::PaymentSourceType)] [Optional] Specifies which payment method options to
    #     not present to the customer.
    # @!attribute products
    #   @return [Array(CheckoutSdk::Common::Product)] [Optional] Contains details about the products in the order.
    # @!attribute risk
    #   @return [RiskRequest] [Optional] Configures the risk assessment performed during payment processing.
    # @!attribute customer_retry
    #   @return [CheckoutSdk::Common::CustomerRetry] [Optional] Configures the parameters for customer retries
    #     performed by the customer on the checkout page.
    # @!attribute sender
    #   @return [CheckoutSdk::Payments::Sender] [Optional] The sender of the payment.
    # @!attribute metadata
    #   @return [Hash(String=>Object)] [Optional] Allows you to store additional information about the transaction.
    # @!attribute locale
    #   @return [String] {LocaleType} [Optional] Creates a translated version of the page in the specified language
    # @!attribute three_ds
    #   @return [ThreeDSRequest] [Optional] Information required for 3D Secure payments
    # @!attribute capture
    #   @return [TrueClass, FalseClass] [Optional] Whether to capture the payment (if applicable).
    # @!attribute capture_on
    #   @return [Time] [Optional] A timestamp (ISO 8601 code) that determines when the payment should be captured.
    # @!attribute instruction
    #   @return [HostedPaymentInstruction] [Optional] Details about the payment instruction.
    # @!attribute payment_method_configuration
    #   @return [PaymentMethodConfiguration] [Optional] Configuration options for specific payment methods.
    # @!attribute payment_plan
    #   @return [PaymentPlan] [Optional] The information to process a recurring payment request.
    #     To be used when the payment_type is Recurring.
    # @!attribute authorization_type
    #   @return [String] [Optional] {AuthorizationType} Enum: "Final" "Estimated". Default: "Final".
    class HostedPaymentsSession
      attr_accessor :currency,
                    :billing,
                    :success_url,
                    :cancel_url,
                    :failure_url,
                    :amount,
                    :payment_type,
                    :payment_ip,
                    :billing_descriptor,
                    :reference,
                    :description,
                    :display_name,
                    :processing_channel_id,
                    :amount_allocations,
                    :customer,
                    :shipping,
                    :recipient,
                    :processing,
                    :allow_payment_methods,
                    :disabled_payment_methods,
                    :products,
                    :risk,
                    :customer_retry,
                    :sender,
                    :metadata,
                    :locale,
                    :three_ds,
                    :capture,
                    :capture_on,
                    :instruction,
                    :payment_method_configuration,
                    :payment_plan,
                    :authorization_type

      def initialize(payment_type: CheckoutSdk::Payments::PaymentType::REGULAR)
        @payment_type = payment_type
      end
    end
  end
end
