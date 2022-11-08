# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute assessment_id
    #   @return [String]
    # @!attribute date
    #   @return [DateTime]
    # @!attribute source
    #   @return [RiskPaymentSource]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest]
    # @!attribute amount
    #   @return [Integer]
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute payment
    #   @return [RiskPayment]
    # @!attribute shipping
    #   @return [RiskShippingDetails]
    # @!attribute device
    #   @return [Device]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    # @!attribute authentication_result
    #   @return [AuthenticationResult]
    # @!attribute authorization_result
    #   @return [AuthorizationResult]
    class PreCaptureAssessment
      attr_accessor :assessment_id,
                    :date,
                    :source,
                    :customer,
                    :amount,
                    :currency,
                    :payment,
                    :shipping,
                    :device,
                    :metadata,
                    :authentication_result,
                    :authorization_result
    end
  end
end
