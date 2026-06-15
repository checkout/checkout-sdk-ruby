# frozen_string_literal: true

module CheckoutSdk
  module NetworkTokens
    # Request body for POST /network-tokens/{network_token_id}/cryptograms.
    #
    # @!attribute transaction_type
    #   @return [String] One of "ecom", "recurring", "pos", "aft".
    class NetworkTokenCryptogramRequest
      attr_accessor :transaction_type
    end
  end
end
