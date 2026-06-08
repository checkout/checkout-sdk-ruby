# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for POST /issuing/simulate/oob/authentication.
    #
    # @!attribute card_id
    #   @return [String] The card's unique identifier (e.g. "crd_...").
    # @!attribute transaction_details
    #   @return [OobSimulateTransactionDetails]
    class OobAuthenticationRequest
      attr_accessor :card_id, :transaction_details
    end
  end
end
