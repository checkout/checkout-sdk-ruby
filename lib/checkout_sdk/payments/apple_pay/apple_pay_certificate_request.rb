# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Request body for POST /applepay/certificates.
    #
    # @!attribute content
    #   @return [String] PEM-encoded certificate content.
    class ApplePayCertificateRequest
      attr_accessor :content
    end
  end
end
