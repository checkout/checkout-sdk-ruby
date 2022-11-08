# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute date
    #   @return [DateTime]
    # @!attribute source
    #   @return [RiskPaymentSource]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest]
    # @!attribute payment
    #   @return [RiskPayment]
    # @!attribute shipping
    #   @return [RiskShippingDetails]
    # @!attribute reference
    #   @return [String]
    # @!attribute description
    #   @return [String]
    # @!attribute amount
    #   @return [Integer]
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute device
    #   @return [Device]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    class PreAuthenticationAssessment
      attr_accessor :date,
                    :source,
                    :customer,
                    :payment,
                    :shipping,
                    :reference,
                    :description,
                    :amount,
                    :currency,
                    :device,
                    :metadata
    end
  end
end
