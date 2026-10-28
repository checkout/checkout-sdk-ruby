# frozen_string_literal: true

require 'checkout_sdk/payments/payment_type'

module CheckoutSdk
  module Payments
    # @!attribute amount
    #   @return [Integer] [Required] The payment amount.
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency} [Required] The three-letter ISO currency code of the
    #     payment. The `currency` and `billing.address.country` fields determine which payment methods are shown on the
    #     payment page.
    # @!attribute payment_type
    #   @return [String] {PaymentType} [Optional] This must be specified for card payments where the cardholder is not
    #     present (i.e., recurring or mail order / telephone order). Default: "Regular".
    # @!attribute payment_ip
    #   @return [String] [Optional] The Customers IP address. Only IPv4 and IPv6 addresses are accepted.
    # @!attribute billing_descriptor
    #   @return [BillingDescriptor] [Optional] An optional description that is displayed on the customer's statement
    #     identifying a purchase
    # @!attribute reference
    #   @return [String] [Optional] A reference you can use to identify the payment.
    # @!attribute description
    #   @return [String] [Optional] A description of the payment.
    # @!attribute display_name
    #   @return [String] [Optional] The merchant name to display to customers on the checkout page.
    # @!attribute processing_channel_id
    #   @return [String] [Optional] The processing channel to use for the payment. This field is required if you
    #     have more than one processing channel associated with your API key.
    # @!attribute amount_allocations
    #   @return [Array(CheckoutSdk::Common::AmountAllocations)] [Optional] The sub-entities that the payment is being
    #     processed on behalf of.
    # @!attribute expires_in
    #   @return [Integer] [Optional] The time for which the link remains valid, in seconds. Minimum 1, maximum 5184000.
    #     Default: 86400.
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest] [Optional] The customer's details
    # @!attribute shipping
    #   @return [ShippingDetails] [Optional] The address any products are being sent to.
    # @!attribute billing
    #   @return [BillingInformation] [Required] The billing details.
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
    # @!attribute metadata
    #   @return [Hash(String=>Object)] [Optional] Allows you to store additional information about the transaction.
    # @!attribute three_ds
    #   @return [ThreeDSRequest] [Optional] Information required for 3D Secure payments.
    # @!attribute risk
    #   @return [RiskRequest] [Optional] Configures the risk assessment performed during payment processing.
    # @!attribute customer_retry
    #   @return [CheckoutSdk::Common::CustomerRetry] [Optional] Configures the parameters for customer retries
    #     performed by the customer on the checkout page.
    # @!attribute sender
    #   @return [CheckoutSdk::Payments::Sender] [Optional] The sender of the payment.
    # @!attribute return_url
    #   @return [String] [Optional] If provided, the success page will include a button that redirects your customer
    #     to the provided URL.
    # @!attribute locale
    #   @return [String] [Optional] Creates a translated version of the page in the specified language.
    #     Default: "en-GB".
    # @!attribute capture
    #   @return [TrueClass, FalseClass] [Optional] Whether to capture the payment (if applicable).
    # @!attribute capture_on
    #   @return [Time] [Optional] A timestamp (ISO 8601 code) that determines when the payment should be captured.
    # @!attribute payment_plan
    #   @return [PaymentPlan] [Optional] The information to process a recurring payment request.
    #     To be used when the payment_type is Recurring.
    # @!attribute instruction
    #   @return [HostedPaymentInstruction] [Optional] Details about the payment instruction.
    # @!attribute payment_method_configuration
    #   @return [PaymentMethodConfiguration] [Optional] Configuration options for specific payment methods.
    # @!attribute authorization_type
    #   @return [String] [Optional] {AuthorizationType} Enum: "Final" "Estimated". Default: "Final".
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
                    :capture_on,
                    :payment_plan,
                    :authorization_type,
                    :instruction,
                    :payment_method_configuration

      def initialize(payment_type: CheckoutSdk::Payments::PaymentType::REGULAR)
        @payment_type = payment_type
      end
    end
  end
end
