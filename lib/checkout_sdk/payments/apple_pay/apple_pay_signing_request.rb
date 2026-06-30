# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Request body for POST /applepay/signing-requests.
    #
    # @!attribute protocol_version
    #   @return [String] CSR protocol version.
    class ApplePaySigningRequest
      attr_accessor :protocol_version
    end
  end
end
