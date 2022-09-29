# frozen_string_literal: true

module CheckoutSdk
  module Tokens
    # @!attribute signature
    #   @return [String]
    # @!attribute protocolVersion
    #   @return [String]
    # @!attribute signedMessage
    #   @return [String]
    class GooglePayTokenData
      attr_accessor :signature,
                    :protocolVersion,
                    :signedMessage
    end
  end
end
