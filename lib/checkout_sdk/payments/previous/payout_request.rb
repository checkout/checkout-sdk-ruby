# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute destination
      #   @return [Destination]
      # @!attribute amount
      #   @return [Integer]
      # @!attribute fund_transfer_type
      #   @return [String] {FundTransferType}
      # @!attribute currency
      #   @return [String] {CheckoutSdk::Common::Currency}
      # @!attribute payment_type
      #   @return [String] {CheckoutSdk::Payments::PaymentType}
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
      #   @return [Hash{String => Object}]
      # @!attribute metadata
      #   @return [Hash{String => Object}]
      class PayoutRequest
        attr_accessor :destination,
                      :amount,
                      :fund_transfer_type,
                      :currency,
                      :payment_type,
                      :reference,
                      :description,
                      :capture,
                      :capture_on,
                      :customer,
                      :billing_descriptor,
                      :shipping,
                      :previous_payment_id,
                      :risk,
                      :success_url,
                      :failure_url,
                      :payment_ip,
                      :recipient,
                      :metadata,
                      :processing
      end
    end
  end
end
