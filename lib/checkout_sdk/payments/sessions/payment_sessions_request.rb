# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute amount
    #   @return [Integer] [Required] The payment amount.
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency} [Required] The three-letter ISO currency code.
    # @!attribute payment_type
    #   @return [TrueClass, FalseClass] [Optional] Must be specified for card-not-present (CNP) payments.
    # @!attribute billing
    #   @return [BillingInformation] [Required] The billing details.
    # @!attribute billing_descriptor
    #   @return [BillingDescriptor] [Optional] A description of the purchase, which is displayed on the customer's
    #     statement.
    # @!attribute reference
    #   @return [String] [Optional] A reference you can use to identify the payment.
    # @!attribute description
    #   @return [String] [Optional] A description for the payment.
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest] [Optional] The customer's details.
    # @!attribute shipping
    #   @return [ShippingDetails] [Optional] The shipping details
    # @!attribute recipient
    #   @return [PaymentRecipient] [Optional] Information about the recipient of the payment's funds.
    # @!attribute processing
    #   @return [ProcessingSettings] [Optional] Use the processing object to influence or override the data sent
    #     during card processing
    # @!attribute processing_channel_id
    #   @return [String] [Optional] The processing channel to use for the payment.
    # @!attribute expires_on
    #   @return [Time] [Optional] A timestamp specifying when the `PaymentSession` should expire, as an ISO 8601 code.
    # @!attribute payment_method_configuration
    #   @return [PaymentMethodConfiguration] [Optional] Configurations for payment method-specific settings.
    # @!attribute enabled_payment_methods
    #   @return [Array(PaymentMethodsType)] [Optional] Specifies which payment method options to present to the
    #     customer.
    # @!attribute disabled_payment_methods
    #   @return [Array(PaymentMethodsType)] [Optional] Specifies which payment method options to not present to the
    #     customer.
    # @!attribute items
    #   @return [Array(Product)] [Optional] The line items in the order.
    # @!attribute amount_allocations
    #   @return [Array(CheckoutSdk::Common::AmountAllocations)] [Optional] The sub-entities that the payment is being
    #     processed on behalf of.
    # @!attribute risk
    #   @return [RiskRequest] [Optional] Configures the risk assessment performed during payment processing.
    # @!attribute retry
    #   @return [PaymentRetryRequest] [Optional] Configuration of asynchronous retries.
    #   @deprecated Not part of the payment sessions specification. Please use {#customer_retry} instead.
    #     This attribute will be removed in the next major version.
    # @!attribute customer_retry
    #   @return [CheckoutSdk::Common::CustomerRetry] [Optional] Configures the parameters for customer retries
    #     performed by the customer on the checkout page. max_attempts is the maximum number of customer retry
    #     attempts, excluding the initial payment attempt (minimum 0, maximum 5, default 5); it is required
    #     when customer_retry is set.
    # @!attribute display_name
    #   @return [String] [Optional] The merchant's display name.
    # @!attribute success_url
    #   @return [String] [Required] Overrides the default success redirect URL configured on your account, for payment
    #     methods that require a redirect.
    # @!attribute failure_url
    #   @return [String] [Required] Overrides the default failure redirect URL configured on your account, for payment
    #     methods that require a redirect.
    # @!attribute metadata
    #   @return [Hash{String => Object}] [Optional] Allows you to store additional information about a transaction
    #     with custom fields and up to five user-defined fields, which can be used for reporting purposes.
    # @!attribute locale
    #   @return [String] [Optional] Creates a translated version of the page in the specified language.
    # @!attribute three_ds
    #   @return [ThreeDSRequest] [Optional] Information required for 3D Secure authentication payments.
    # @!attribute sender
    #   @return [Sender] [Optional] The sender of the payment.
    # @!attribute capture
    #   @return [TrueClass, FalseClass] [Optional] Specifies whether to capture the payment, if applicable.
    # @!attribute ip_address
    #   @return [String] [Optional] The Customers IP address.
    # @!attribute capture_on
    #   @return [Time] [Optional] A timestamp specifying when to capture the payment, as an ISO 8601 code.
    # @!attribute tax_amount
    #   @return [Integer] [Optional] The total tax amount, in the minor currency unit.
    # @!attribute authorization_type
    #   @return [String] [Optional] {AuthorizationType} Enum: "Final" "Estimated". Default: "Final".
    # @!attribute payment_plan
    #   @return [PaymentPlan] [Optional] The information to process a recurring payment request.
    #     To be used when the payment_type is Recurring.
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
                    :customer_retry,
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
                    :tax_amount,
                    :authorization_type,
                    :payment_plan
    end
  end
end
