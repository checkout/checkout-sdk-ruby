# frozen_string_literal: true

module CheckoutSdk
  module NetworkTokens
    # Request body for POST /network-tokens.
    # `source` must be either a NetworkTokenSourceCard or a NetworkTokenSourceId.
    #
    # @!attribute source
    #   @return [NetworkTokenSourceCard, NetworkTokenSourceId]
    class ProvisionNetworkTokenRequest
      attr_accessor :source
    end
  end
end
