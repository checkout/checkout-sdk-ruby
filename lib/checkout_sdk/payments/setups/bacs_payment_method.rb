# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The Bacs payment method's details and configuration on a Payment Setup. Maps swagger `Bacs`.
    # Sent under the `payment_methods.bacs` key.
    class BacsPaymentMethod
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

      # The initialization state of the payment method.
      # When you create a Payment Setup, this defaults to `disabled`.
      # [Optional]
      # Enum: "disabled" "enabled"
      # Default: disabled
      # @return [String] One of {PaymentSetupPaymentMethodInitialization}.
      attr_accessor :initialization

      # The ID of the Bacs instrument used for the payment.
      # [Optional]
      # Read only.
      # @return [String]
      attr_accessor :instrument_id

      # The account holder details.
      # [Optional]
      # Keys:
      # - `type` (String): The type of account holder. Enum: "individual" "corporate".
      # - `first_name` (String): The first name of the account holder.
      # - `last_name` (String): The last name of the account holder.
      # - `company_name` (String): The legal name of a registered company that holds the account.
      # - `email` (String): The email address of the account holder.
      # @return [Hash]
      attr_accessor :account_holder

      # The account number of the Bacs Direct Debit account.
      # [Optional]
      # Write only.
      # @return [String]
      attr_accessor :account_number

      # The sort code of the Bacs Direct Debit account.
      # [Optional]
      # Write only.
      # @return [String]
      attr_accessor :bank_code

      # The account's country, as an ISO 3166-1 alpha-2 code.
      # [Optional]
      # min 2 characters, max 2 characters
      # @return [String] {CheckoutSdk::Common::Country}
      attr_accessor :country

      # The account holder's account currency.
      # [Optional]
      # @return [String] {CheckoutSdk::Common::Currency}
      attr_accessor :currency

      # Indicates whether the Bacs instrument is created when account validation returns a partial
      # match. When `true`, the instrument is created on a partial match; when `false`, instrument
      # creation fails on a partial match.
      # [Optional]
      # Default: false
      # @return [TrueClass, FalseClass]
      attr_accessor :allow_partial_match
    end
  end
end
