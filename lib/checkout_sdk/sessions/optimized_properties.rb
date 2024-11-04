# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute field
    #   @return [String]
    # @!attribute original_value
    #   @return [String]
    # @!attribute optimized_value
    #   @return [String]
    class OptimizedProperties
      attr_accessor :field,
                    :original_value,
                    :optimized_value
    end
  end
end
