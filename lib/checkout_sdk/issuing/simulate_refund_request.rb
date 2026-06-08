# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for POST /issuing/simulate/authorizations/{id}/refunds.
    #
    # @!attribute amount
    #   @return [Integer]
    class SimulateRefundRequest
      attr_accessor :amount
    end
  end
end
