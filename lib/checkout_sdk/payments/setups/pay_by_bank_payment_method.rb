# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Pay by Bank (Open Banking) payment method configuration on a Payment Setup.
    # Maps swagger `PayByBank`.
    #
    # @!attribute status
    #   @return [String] (response-only) Payment method status.
    # @!attribute flags
    #   @return [Array(String)] (response-only) Diagnostic flags returned by the API.
    # @!attribute bank_id
    #   @return [String] The identifier of the bank the customer has selected for the payment.
    # @!attribute action
    #   @return [Hash] (response-only) The next available action for the payment method
    #     (`type`, `banks`).
    class PayByBankPaymentMethod
      attr_accessor :status,
                    :flags,
                    :bank_id,
                    :action
    end
  end
end
