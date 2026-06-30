# frozen_string_literal: true

module CheckoutSdk
  module AgenticCommerce
    # Risk signal attached to a delegated payment request. Mirrors swagger
    # `DelegatedPaymentRiskSignal`. All three fields are required per spec.
    #
    # @!attribute type
    #   @return [String] Risk signal type. [Required]
    # @!attribute score
    #   @return [Integer] Risk score. [Required]
    # @!attribute action
    #   @return [String] Action taken based on the risk assessment. [Required]
    class DelegatedPaymentRiskSignal
      attr_accessor :type,
                    :score,
                    :action
    end
  end
end
