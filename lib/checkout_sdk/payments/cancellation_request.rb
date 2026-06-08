# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Request body for POST /payments/{id}/cancellations.
    #
    # @!attribute reference
    #   @return [String] Optional merchant reference (max 80 chars).
    class CancellationRequest
      attr_accessor :reference
    end
  end
end
