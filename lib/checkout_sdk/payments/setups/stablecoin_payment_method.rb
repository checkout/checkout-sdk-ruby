# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Stablecoin payment method configuration on a Payment Setup. Maps swagger `Stablecoin`.
    #
    # @!attribute status
    #   @return [String] (response-only) Payment method status.
    # @!attribute flags
    #   @return [Array(String)] (response-only) Diagnostic flags returned by the API.
    class StablecoinPaymentMethod
      attr_accessor :status,
                    :flags
    end
  end
end
