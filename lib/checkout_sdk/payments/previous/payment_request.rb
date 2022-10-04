# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute source
      #   @return [PaymentSource]
      # @!attribute amount
      #   @return [Integer]
      # @!attribute currency
      #   @return [String] {CheckoutSdk::Common::Currency}
      # @!attribute payment_type
      #   @return [String] {CheckoutSdk::Payments::PaymentType}
      # @!attribute merchant_initiated
      #   @return [TrueClass, FalseClass]
      # @!attribute reference
      #   @return [String]
      # @!attribute description
      #   @return [String]
      # @!attribute capture
      #   @return [TrueClass, FalseClass]
      # @!attribute capture_on
      #   @return [Time]
      # @!attribute customer
      #   @return [CheckoutSdk::Common::CustomerRequest]
      # @!attribute billing_descriptor
      #   @return [CheckoutSdk::Payments::BillingDescriptor]
      # @!attribute shipping
      #   @return [CheckoutSdk::Payments::ShippingDetails]
      # @!attribute three_ds
      #   @return [CheckoutSdk::Payments::ThreeDSRequest]
      # @!attribute previous_payment_id
      #   @return [String]
      # @!attribute risk
      #   @return [CheckoutSdk::Payments::RiskRequest]
      # @!attribute success_url
      #   @return [String]
      # @!attribute failure_url
      #   @return [String]
      # @!attribute payment_ip
      #   @return [String]
      # @!attribute recipient
      #   @return [CheckoutSdk::Payments::PaymentRecipient]
      # @!attribute processing
      #   @return [CheckoutSdk::Payments::ProcessingSettings]
      # @!attribute metadata
      #   @return [Hash{String => Object}]
      class PaymentRequest
        attr_accessor :source,
                      :amount,
                      :currency,
                      :payment_type,
                      :merchant_initiated,
                      :reference,
                      :description,
                      :capture,
                      :capture_on,
                      :customer,
                      :billing_descriptor,
                      :shipping,
                      :three_ds,
                      :previous_payment_id,
                      :risk,
                      :success_url,
                      :failure_url,
                      :payment_ip,
                      :recipient,
                      :processing,
                      :metadata
      end
    end
  end
end
