# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute applepay
    #   @return [Applepay]
    # @!attribute card
    #   @return [Card]
    # @!attribute googlepay
    #   @return [Googlepay]
    class PaymentMethodConfiguration
      attr_accessor :applepay,
                    :card,
                    :googlepay
    end
  end
end
