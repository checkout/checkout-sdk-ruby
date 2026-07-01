# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Bacs payment method configuration on a Payment Setup. Maps swagger `Bacs`.
    #
    # @!attribute status
    #   @return [String] (response-only) Payment method status.
    # @!attribute flags
    #   @return [Array(String)] (response-only) Diagnostic flags returned by the API.
    # @!attribute initialization
    #   @return [String] The initialization type for the payment method.
    # @!attribute instrument_id
    #   @return [String] (response-only) The ID of the Bacs instrument used for the payment.
    # @!attribute account_holder
    #   @return [Hash] The account holder details (`type`, `first_name`, `last_name`,
    #     `company_name`, `email`).
    # @!attribute account_number
    #   @return [String] The account number of the Bacs Direct Debit account.
    # @!attribute bank_code
    #   @return [String] The bank code (sort code) of the Bacs Direct Debit account.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute allow_partial_match
    #   @return [TrueClass, FalseClass] Whether to allow a partial match of the account holder details.
    class BacsPaymentMethod
      attr_accessor :status,
                    :flags,
                    :initialization,
                    :instrument_id,
                    :account_holder,
                    :account_number,
                    :bank_code,
                    :country,
                    :currency,
                    :allow_partial_match
    end
  end
end
