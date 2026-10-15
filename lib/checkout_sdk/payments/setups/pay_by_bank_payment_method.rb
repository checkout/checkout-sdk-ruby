# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The Pay by Bank (Open Banking) payment method's details and configuration on a Payment Setup.
    # Maps swagger `PayByBank`. Sent under the `payment_methods.paybybank` key (one lowercase word,
    # not `pay_by_bank`; the API ignores `pay_by_bank` without an error).
    #
    # The Payment Setup request is a Hash, and a Hash request is sent as is, so do not nest an
    # instance of this class in it directly: it would not be serialized. Pass a Hash with these keys,
    # or convert an instance first:
    #   pay_by_bank = CheckoutSdk::Payments::PayByBankPaymentMethod.new
    #   pay_by_bank.bank_id = 'ob-natwest'
    #   request[:payment_methods] = { paybybank: CheckoutSdk::JsonSerializer.to_custom_hash(pay_by_bank) }
    # Responses are read with dot access, for example response.payment_methods.paybybank.action.banks.
    class PayByBankPaymentMethod
      # The payment method status.
      # [Optional]
      # Read only.
      # Enum: "unavailable" "action_required" "ready" "initialization_required" "invalid"
      # @return [String] One of {PaymentSetupPaymentMethodStatus}.
      attr_accessor :status

      # The list of error codes or indicators that highlight missing or invalid information.
      # [Optional]
      # Read only.
      # @return [Array(String)]
      attr_accessor :flags

      # The identifier of the bank the customer has selected for the payment.
      # [Optional]
      # @return [String]
      attr_accessor :bank_id

      # The next available action for the payment method.
      # [Optional]
      # Read only.
      # Keys:
      # - `type` (String): The type of action. Enum: "select_bank".
      # - `banks` (Array(Hash)): The list of banks available for the customer to select. Each item has
      #   `bank_id` (String, the unique identifier of the bank), `display_name` (String, the display
      #   name of the bank), `logo_url` (String, the URL of the bank's logo) and `available`
      #   (Boolean, whether the bank is currently available for selection).
      # @return [Hash]
      attr_accessor :action
    end
  end
end
