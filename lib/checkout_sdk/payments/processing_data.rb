# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Response-side `processing` object returned alongside payment responses.
    # Distinct from {ProcessingSettings} which is the request-side equivalent.
    #
    # Mirrors the swagger ProcessingData schema, referenced by PaymentDetails.processing
    # (GET /payments/{id}).
    #
    # @!attribute preferred_scheme
    #   @return [String] [Optional] The preferred scheme for co-badged card payment processing.
    #     If performing 3DS via a third party, this is the scheme that processed 3DS. Does not
    #     support PINless debit schemes in the US (STAR, PULSE, NYCE, ACCEL, SHAZAM).
    #     Enum: "mastercard" "visa" "cartes_bancaires"
    # @!attribute app_id
    #   @return [String] [Optional] The customer's application identifier.
    # @!attribute partner_customer_id
    #   @return [String] [Optional] The customer's ID on the partner platform.
    # @!attribute partner_payment_id
    #   @return [String] [Optional] The partner-originated unique payment identifier.
    # @!attribute tax_amount
    #   @return [Numeric] [Optional] Total tax amount of the order.
    # @!attribute locale
    #   @return [String] [Optional] The language and region of the customer. ISO 639-2 language
    #     code, its value consists of language-country. Pattern:
    #     ^[a-z]{2}(?:-[A-Z][a-z]{3})?(?:-(?:[A-Z]{2}))?$ - min 2 characters, max 10 characters
    # @!attribute retrieval_reference_number
    #   @return [String] [Optional] A unique identifier for the authorization provided by partner.
    # @!attribute partner_order_id
    #   @return [String] [Optional] The Klarna order ID associated with the payment.
    # @!attribute partner_status
    #   @return [String] [Optional] Status of a payment provided by partner.
    # @!attribute partner_transaction_id
    #   @return [String] [Optional] Unique transaction identification provided by partner.
    # @!attribute partner_error_codes
    #   @return [Array<String>] [Optional] The list of error codes that led the payment to fail or
    #     be declined, as given by the payment provider.
    # @!attribute partner_error_message
    #   @return [String] [Optional] Error description provided by partner.
    # @!attribute partner_authorization_code
    #   @return [String] [Optional] Authorization code provided by partner.
    # @!attribute partner_authorization_response_code
    #   @return [String] [Optional] Authorization response code provided by partner.
    # @!attribute partner_fraud_status
    #   @return [String] [Optional] Partner fraud status. If the status is Pending, and the
    #     merchant captures before it changes to Accepted, the risk of the transaction is solely
    #     on the merchant.
    # @!attribute partner_merchant_advice_code
    #   @return [String] [Optional] The Mastercard Merchant Advice Code (MAC), which contains
    #     additional information about the transaction. For declined transactions it also
    #     indicates whether the payment can be retried and how long to wait.
    # @!attribute custom_payment_method_ids
    #   @return [Array<String>] [Optional] An array defining which of the configured payment
    #     options within a payment category (for example, pay_later or pay_over_time) should be
    #     displayed for this purchase.
    # @!attribute aft
    #   @return [Boolean] [Optional] Indicates whether the payment is an Account Funding
    #     Transaction.
    # @!attribute merchant_category_code
    #   @return [String] [Optional] Four-digit code for retail financial services expressed in
    #     ISO 18245 format, classifying the types of goods or services you provide.
    # @!attribute scheme_merchant_id
    #   @return [String] [Optional] The merchant identifier that was configured with the scheme
    #     and used for the payment.
    # @!attribute pan_type_processed
    #   @return [String] [Optional] The type of Primary Account Number (PAN) used for the payment.
    #     DPAN indicates a network token was used, FPAN indicates the full card was used.
    #     Enum: "fpan" "dpan"
    # @!attribute fallback_source_used
    #   @return [Boolean] [Optional] Indicates whether the fallback_source field was used for
    #     the payment.
    # @!attribute failure_code
    #   @return [String] [Optional] A high-level failure category returned by the payment provider
    #     when a payment is declined or fails. Not all payment methods return this field.
    # @!attribute partner_code
    #   @return [String] [Optional] The 6-digit partner code returned by the payment provider.
    #     Returned when source.type is blik. Pattern: ^\d{6}$ - 6 characters
    # @!attribute partner_response_code
    #   @return [String] [Optional] The raw response code returned by the payment provider when a
    #     payment is declined or fails. Not all payment methods return this field.
    # @!attribute scheme
    #   @return [String] [Optional] The scheme on which the payment was authorized. This may
    #     differ from the card's scheme used for the payment if the card is co-badged and the
    #     payment was authorized on a different network. Read-only.
    # @!attribute accommodation_data
    #   @return [Array<AccommodationData>] [Optional] Contains information about the accommodation
    #     booked by the customer.
    # @!attribute airline_data
    #   @return [Array<AirlineData>] [Optional] Contains information about the airline ticket and
    #     flights booked by the customer.
    # @!attribute scheme_transaction_link_id
    #   @return [String] [Optional] The scheme transaction link identifier. Returned for
    #     Mastercard transactions when the scheme provides a link identifier that ties together
    #     related transactions on the network.
    class ProcessingData
      attr_accessor :preferred_scheme,
                    :app_id,
                    :partner_customer_id,
                    :partner_payment_id,
                    :tax_amount,
                    :locale,
                    :retrieval_reference_number,
                    :partner_order_id,
                    :partner_status,
                    :partner_transaction_id,
                    :partner_error_codes,
                    :partner_error_message,
                    :partner_authorization_code,
                    :partner_authorization_response_code,
                    :partner_fraud_status,
                    :partner_merchant_advice_code,
                    :custom_payment_method_ids,
                    :aft,
                    :merchant_category_code,
                    :scheme_merchant_id,
                    :pan_type_processed,
                    :fallback_source_used,
                    :failure_code,
                    :partner_code,
                    :partner_response_code,
                    :scheme,
                    :accommodation_data,
                    :airline_data,
                    :scheme_transaction_link_id
    end
  end
end
