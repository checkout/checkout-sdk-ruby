# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute reference
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    class ReverseRequest
      attr_accessor :reference,
                    :metadata
    end
  end
end
