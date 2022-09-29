# frozen_string_literal: true

module CheckoutSdk
  module Tokens
    # @!attribute version
    #   @return [String]
    # @!attribute data
    #   @return [String]
    # @!attribute signature
    #   @return [String]
    # @!attribute header
    #   @return [Hash{String => Object]
    class ApplePayTokenData
      attr_accessor :version,
                    :data,
                    :signature,
                    :header
    end
  end
end
