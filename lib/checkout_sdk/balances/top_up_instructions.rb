# frozen_string_literal: true

module CheckoutSdk
  module Balances
    # The bank details and payment reference used to top up a sub-account
    # (swagger schema: TopUpInstructionsResponse).
    #
    # Returned by
    # GET /entities/{entityId}/currency-accounts/{currencyAccountId}/top-up-instructions.
    #
    # @!attribute currency_account_id
    #   [Required]
    #   @return [String] The unique identifier of the sub-account that the instructions apply to.
    # @!attribute currency
    #   [Required]
    #   @return [String] {CheckoutSdk::Common::Currency} The currency that funds must be sent in,
    #     as a three-letter ISO 4217 currency code. This is the sub-account's holding currency,
    #     returned as `holding_currency` by the Retrieve entity balances endpoint.
    # @!attribute payment_reference
    #   [Required]
    #   @return [String] The reference that must be quoted on the payment. It is how an incoming
    #     payment is attributed to the sub-account. A payment sent without this reference may not
    #     be credited.
    # @!attribute bank_details
    #   [Required]
    #   @return [TopUpBankDetails] The bank details for each available funding rail.
    class TopUpInstructions
      attr_accessor :currency_account_id,
                    :currency,
                    :payment_reference,
                    :bank_details
    end
  end
end
