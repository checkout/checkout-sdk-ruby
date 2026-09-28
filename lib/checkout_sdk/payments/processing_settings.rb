# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Settings that control how the payment is processed.
    #
    # One shared type covering several request shapes: `POST /payments` resolves to
    # `PaymentRequestProcessing`, while hosted payments, payment links and payment sessions
    # resolve to the wider `PaymentInterfacesProcessing`. A property is therefore not necessarily
    # read by every endpoint that accepts this object, and the notes below say which.
    #
    # Attributes marked "not in any request processing schema" are retained for backwards
    # compatibility. The gateway discards them.
    #
    # @!attribute order_id
    #   @return [String] The number provided by the cardholder. Purchase order or invoice number
    #     may be used.
    #     [Optional]
    #     max 15 characters
    #     Example: "123456789"
    # @!attribute tax_amount
    #   @return [Numeric] The total amount of sales tax on the total purchase amount.
    #     [Optional]
    #     min 0
    #     Example: 3000
    # @!attribute discount_amount
    #   @return [Numeric] The discount amount applied to the transaction by the merchant.
    #     [Optional]
    #     min 0
    # @!attribute duty_amount
    #   @return [Numeric] The total charges for any import or export duty included in the
    #     transaction.
    #     [Optional]
    #     min 0
    # @!attribute shipping_amount
    #   @return [Numeric] The total freight or shipping and handling charges for the transaction.
    #     [Optional]
    #     min 0
    #     Example: 300
    # @!attribute shipping_tax_amount
    #   @return [Numeric] The tax amount of the freight or shipping and handling charges for the
    #     transaction.
    #     [Optional]
    #     min 0
    #     Example: 100
    # @!attribute surcharge_amount
    #   @return [Integer] Surcharge amount applied to the transaction in minor units by the
    #     merchant.
    #     [Optional]
    #     min 0
    #     Example: 200
    # @!attribute original_order_amount
    #   @return [Numeric] The payment for a merchant's order may be split, and the original order
    #     price indicates the transaction amount of the entire order.
    #     [Optional]
    #     min 0
    # @!attribute foreign_retailer_amount
    #   @return [Integer] The foreign retailer amount the merchant applied to the transaction, in
    #     the minor currency unit.
    #     [Optional]
    #     min 0
    #     Example: 200
    # @!attribute aft
    #   @return [TrueClass, FalseClass] Indicates if the payment is an Account Funding
    #     Transaction.
    #     [Optional]
    # @!attribute preferred_scheme
    #   @return [String] The preferred scheme for co-badged card payment processing. If performing
    #     3DS via a third party, set this value to the scheme that processed 3DS. This field does
    #     not support PINless debit schemes in the US (STAR, PULSE, NYCE, ACCEL, SHAZAM).
    #     [Optional]
    #     One of: mastercard, visa, cartes_bancaires. See {PreferredSchema}
    # @!attribute merchant_initiated_reason
    #   @return [String] Indicates the reason for a merchant-initiated payment request.
    #     [Optional]
    #     One of: Delayed_charge, Resubmission, No_show, Reauthorization.
    #     See {MerchantInitiatedReason}
    # @!attribute campaign_id
    #   @return [Integer] Unique number of the campaign this payment will be running in. Only
    #     required for Afterpay campaign invoices.
    #     [Optional]
    # @!attribute product_type
    #   @return [String] Product type of the payment. Required when `source.type` is `wechatpay`,
    #     optional for `tamara`, required for `sequra`. The accepted values differ per source
    #     type. See {ProductType}
    #     [Optional]
    #     Example: "QR Code"
    # @!attribute open_id
    #   @return [String] Value obtained from the WeChat Web Authorization API before initiating
    #     Official Account or Mini Program payments. Required if `source.type` is `wechatpay` and
    #     `processing.product_type` is `Official Account` or `Mini Program`.
    #     [Optional]
    #     Example: "oUpF8uMuAJO_M2pxb1Q9zNjWeS6o"
    # @!attribute receipt_id
    #   @return [String] Merchant receipt ID.
    #     [Optional]
    #     max 32 characters
    # @!attribute reconciliation_id
    #   @return [String] The transaction identifier to track a payment request.
    #     [Optional]
    #     Example: "4123495123"
    # @!attribute terminal_type
    #   @return [String] The client-side terminal type, whether it is a website opened via a PC
    #     browser, a mobile browser, or a mobile application.
    #     [Optional]
    #     One of: APP, WAP, WEB. See {TerminalType}
    # @!attribute os_type
    #   @return [String] The device operating system. Required when `terminal_type` is not `WEB`.
    #     [Optional]
    #     One of: ANDROID, IOS. See {OsType}
    # @!attribute invoice_id
    #   @return [String] Invoice ID number.
    #     [Optional]
    #     max 127 characters
    # @!attribute brand_name
    #   @return [String] The label that overrides the business name in the PayPal account on the
    #     PayPal pages.
    #     [Optional]
    #     max 127 characters
    #     Declared on `PaymentInterfacesProcessing` only.
    # @!attribute locale
    #   @return [String] The language and region of the customer in ISO 639-2 language code; the
    #     value consists of language-country.
    #     [Optional]
    #     Pattern: ^[a-z]{2}(?:-[A-Z][a-z]{3})?(?:-(?:[A-Z]{2}))?$
    #     min 2 characters, max 10 characters
    #     Example: "en-US"
    # @!attribute shipping_preference
    #   @return [String] The shipping preference for the payment.
    #     [Optional]
    #     One of: no_shipping, set_provided_address, get_from_file. See {ShippingPreference}
    #     Declared on `PaymentContextProcessing` only, so it is read by POST /payment-contexts.
    # @!attribute user_action
    #   @return [String] Property required by PayPal to have an appropriate payment flow.
    #     [Optional]
    #     One of: pay_now, continue. See {UserAction}
    #     Declared on `PaymentContextProcessing` only.
    # @!attribute pan_preference
    #   @return [String] The preferred type of Primary Account Number (PAN) for the payment. Only
    #     works for `source.type` cards, instruments and tokens. `dpan` indicates a preference for
    #     the Checkout.com Network Token, `fpan` for the full card number.
    #     [Optional]
    #     One of: fpan, dpan. See {PanProcessedType}
    # @!attribute provision_network_token
    #   @return [TrueClass, FalseClass] Indicates whether to provision a network token for the
    #     payment.
    #     [Optional]
    # @!attribute card_type
    #   @return [String] Specifies whether to process the payment as a credit or debit
    #     transaction, if a combo card is used. Required for domestic payments in Brazil performed
    #     using a Brazilian card.
    #     [Optional]
    #     One of: credit, debit. See {ProcessingCardType}
    # @!attribute service_type
    #   @return [String] Specifies which ACH service to use for the payment, if you set
    #     `source.type` to `ach`.
    #     [Optional]
    #     One of: same_day, standard. See {AchServiceType}
    # @!attribute purchase_country
    #   @return [String] The two-letter ISO country code of the purchase country. If you are a
    #     Visa-registered ramp provider operating with affiliates, this field is required.
    #     [Optional]
    #     max 2 characters
    #     Example: "GB". See {CheckoutSdk::Common::Country}
    # @!attribute custom_payment_method_ids
    #   @return [Array(String)] Promo codes. They define which of the configured payment options
    #     within a payment category (pay_later, pay_over_time, and so on) are shown for this
    #     purchase.
    #     [Optional]
    #     Declared on `PaymentInterfacesProcessing` only.
    # @!attribute merchant_callback_url
    #   @return [String] A URL which you can use to notify the customer that the order has been
    #     created.
    #     [Optional]
    # @!attribute line_of_business
    #   @return [String] Beta. The line of business that the payment is associated with.
    #     [Optional]
    #     Example: "Flights"
    # @!attribute partner_code
    #   @return [String] The customer's 6-digit Blik code. Required when `source.type` is `blik`
    #     and `merchant_initiated` is `false`.
    #     [Optional]
    #     Pattern: ^\d{6}$
    #     min 6 characters, max 6 characters
    #     Example: "902111"
    # @!attribute scheme_transaction_link_id
    #   @return [String] The scheme transaction link identifier.
    #     [Optional]
    # @!attribute affiliate_id
    #   @return [String] The unique identifier for Visa-registered ramp providers. Must only
    #     contain alphanumeric characters. Required if you are a Visa-registered ramp provider
    #     operating with affiliates.
    #     [Optional]
    #     Pattern: ^[a-zA-Z0-9]{1,15}$
    #     max 15 characters
    # @!attribute affiliate_url
    #   @return [String] The affiliate URL. Required if you are a Visa-registered ramp provider
    #     operating with affiliates.
    #     [Optional]
    #     Example: "www.mycrypto.com"
    # @!attribute aggregator
    #   @return [Aggregator] Information about the payment aggregator.
    #     [Optional]
    # @!attribute partner_customer_risk_data
    #   @return [PartnerCustomerRiskData] Key-and-value pair with merchant-specific data for the
    #     transaction.
    #     [Optional]
    #     Declared on `PaymentInterfacesProcessing` and `PaymentContextProcessing`, not on
    #     `PaymentRequestProcessing`.
    # @!attribute airline_data
    #   @return [Array(AirlineData)] Contains information about the airline ticket and flights
    #     booked by the customer.
    #     [Optional]
    # @!attribute accommodation_data
    #   @return [Array(AccommodationData)] Contains information about the accommodation booked by
    #     the customer.
    #     [Optional]
    # @!attribute set_transaction_context
    #   @return [Array(Hash{String => String})] Additional transaction context information.
    #     [Optional]
    #     Not in any request processing schema, in either specification. Serializes as
    #     `set_transaction_context`, which no schema defines, so the gateway discards it. Retained
    #     for backwards compatibility.
    # @!attribute otp_value
    #   @return [String] The one-time password value for authentication.
    #     [Optional]
    #     Not on `PaymentRequestProcessing` or `PaymentInterfacesProcessing`. It is declared on
    #     the payment contexts payment request and on the capture request only, so setting it here
    #     has no effect.
    # @!attribute shipping_delay
    #   @return [Integer] The shipping delay in days.
    #     [Optional]
    #     Not in any request processing schema, in either specification. The gateway discards it.
    #     Retained for backwards compatibility.
    # @!attribute shipping_info
    #   @return [Array(CheckoutSdk::Common::ShippingInfo)] Additional shipping information for the
    #     payment.
    #     [Optional]
    #     Not in any request processing schema, in either specification. The gateway discards it.
    #     Retained for backwards compatibility.
    # @!attribute dlocal
    #   @return [DLocalProcessingSettings] dLocal-specific processing settings.
    #     [Optional]
    #     Previous API (ABC) only. Absent from the current (NAS) processing schemas.
    # @!attribute senderInformation
    #   @return [SenderInformation] Sender information for the payment.
    #     [Optional]
    #     Not in the current specification. The property appears under neither
    #     `senderInformation` nor `sender_information` in any spec available to this workspace,
    #     including the live API reference, and no processing schema declares a sender property of
    #     any kind. Deprecated in practice; the current API carries sender details in the top
    #     level `sender` object on the payment request instead.
    #
    #     Left exactly as it is on purpose. Ruby uses attribute names as wire keys verbatim, so
    #     this goes out as `senderInformation`. That camelCase spelling is long standing across
    #     the SDK family but has never been confirmed against a live ABC endpoint, so treat it as
    #     unverified rather than correct, and do not change it in either direction without such a
    #     confirmation.
    # @!attribute purpose
    #   @return [String] The purpose of the payment.
    #     [Optional]
    #     Not declared on any processing schema in either specification. The name appears
    #     elsewhere in the spec on unrelated objects. The gateway discards it here.
    class ProcessingSettings
      attr_accessor :order_id,
                    :tax_amount,
                    :discount_amount,
                    :duty_amount,
                    :shipping_amount,
                    :shipping_tax_amount,
                    :surcharge_amount,
                    :original_order_amount,
                    :foreign_retailer_amount,
                    :aft,
                    :preferred_scheme,
                    :merchant_initiated_reason,
                    :campaign_id,
                    :product_type,
                    :open_id,
                    :receipt_id,
                    :reconciliation_id,
                    :terminal_type,
                    :os_type,
                    :invoice_id,
                    :brand_name,
                    :locale,
                    :shipping_preference,
                    :user_action,
                    :pan_preference,
                    :provision_network_token,
                    :card_type,
                    :service_type,
                    :purchase_country,
                    :custom_payment_method_ids,
                    :merchant_callback_url,
                    :line_of_business,
                    :partner_code,
                    :scheme_transaction_link_id,
                    :affiliate_id,
                    :affiliate_url,
                    :aggregator,
                    :partner_customer_risk_data,
                    :airline_data,
                    :accommodation_data,
                    :set_transaction_context,
                    :otp_value,
                    :shipping_delay,
                    :shipping_info,
                    :dlocal,
                    :senderInformation,
                    :purpose
    end
  end
end
