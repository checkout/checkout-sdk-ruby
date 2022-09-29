# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute reference
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    class VoidRequest
      attr_accessor :reference,
                    :metadata
    end
  end
end
