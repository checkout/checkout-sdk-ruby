# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Request for PATCH /accounts/entities/{entityId}/payment-instruments/{id}
    # (PlatformsPaymentInstrumentUpdate).
    # @!attribute label
    #   A reference that you can use to identify the payment instrument.
    #   [Optional]
    #   min 1 character, max 50 characters
    #   @return [String]
    # @!attribute default
    #   Deprecated by the API: for scheduled payouts the first payment instrument created for a currency
    #   is used; to change it, update the payout schedule.
    #   [Optional]
    #   @return [TrueClass, FalseClass]
    # @!attribute headers
    #   The payment instrument ETag, as returned in the ETag header of the GET, in headers.if_match.
    #   {AccountsClient#update_payment_instrument} sends it as the If-Match HTTP header; the API
    #   answers 428 without it and 412 when it does not match.
    #   [Required] by the API.
    #   @return [CheckoutSdk::Common::Headers]
    class UpdatePaymentInstrumentRequest
      attr_accessor :label,
                    :default,
                    :headers
    end
  end
end
