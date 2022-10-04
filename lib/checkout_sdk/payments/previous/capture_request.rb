# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute amount
      #   @return [Integer]
      # @!attribute reference
      #   @return [String]
      # @!attribute metadata
      #   @return [Hash{String => Object}]
      class CaptureRequest
        attr_accessor :amount,
                      :reference,
                      :metadata
      end
    end
  end
end
