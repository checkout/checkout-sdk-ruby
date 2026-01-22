# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute token
    #   @return [String]
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute phone
    #   @return [CheckoutSdk::Common::Phone]
    # @!attribute store_for_future_use
    #   @return [TrueClass, FalseClass]
    class TokenSource < RiskPaymentSource
      attr_accessor :token,
                    :billing_address,
                    :phone,
                    :store_for_future_use

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::TOKEN)
      end
    end
  end
end
