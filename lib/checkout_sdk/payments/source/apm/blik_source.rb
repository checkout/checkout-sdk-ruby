# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Blik payment source for the /payments endpoint.
    #
    # When source.type is "blik":
    #   - currency must be PLN
    #   - amount must not exceed 5,000,000 (minor unit)
    #   - reference is limited to 35 characters
    # For customer-initiated payments, provide the 6-digit BLIK code in
    # `processing.partner_code`. For merchant-initiated recurring payments,
    # use either source.type: "id" with a previous source.id, or
    # source.type: "blik" with `partner_agreement_id`.
    #
    # @!attribute id
    #   @return [String] (response-only) The Checkout.com source identifier
    #     for a partner agreement created during a Blik recurring payment.
    # @!attribute partner_agreement_id
    #   @return [String] The Blik PAYID identifying an external partner
    #     agreement created with another PSP.
    class BlikSource < PaymentSource
      attr_accessor :id,
                    :partner_agreement_id

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::BLIK)
      end
    end
  end
end
