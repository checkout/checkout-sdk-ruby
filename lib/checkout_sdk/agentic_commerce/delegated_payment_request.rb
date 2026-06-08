# frozen_string_literal: true

module CheckoutSdk
  module AgenticCommerce
    # Request body for POST /agentic_commerce/delegate_payment.
    #
    # @!attribute payment_method
    #   @return [DelegatedPaymentMethodCard]
    # @!attribute allowance
    #   @return [DelegatedPaymentAllowance]
    # @!attribute billing_address
    #   @return [DelegatedPaymentBillingAddress]
    # @!attribute risk_signals
    #   @return [Array<DelegatedPaymentRiskSignal>]
    # @!attribute metadata
    #   @return [Hash{String => String}] Free-form key/value metadata.
    class DelegatedPaymentRequest
      attr_accessor :payment_method,
                    :allowance,
                    :billing_address,
                    :risk_signals,
                    :metadata
    end
  end
end
