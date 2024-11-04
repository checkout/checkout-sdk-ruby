# frozen_string_literal: true

require 'checkout_sdk/sessions/optimized_properties'

module CheckoutSdk
  module Sessions
    # @!attribute optimized
    #   @return [TrueClass, FalseClass]
    # @!attribute framework
    #   @return [String]
    # @!attribute optimized_properties
    #   @return [Array(OptimizedProperties)]
    class Optimization
      attr_accessor :optimized,
                    :framework,
                    :optimized_properties
    end
  end
end
