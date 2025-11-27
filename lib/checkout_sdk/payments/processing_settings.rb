# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute order_id
    #   @return [String]
    # @!attribute tax_amount
    #   @return [Integer]
    # @!attribute discount_amount
    #   @return [Integer]
    # @!attribute duty_amount
    #   @return [Integer]
    # @!attribute shipping_amount
    #   @return [Integer]
    # @!attribute shipping_tax_amount
    #   @return [Integer]
    # @!attribute aft
    #   @return [TrueClass, FalseClass]
    # @!attribute preferred_scheme
    #   @return [String] {PreferredSchema}
    # @!attribute merchant_initiated_reason
    #   @return [String] {MerchantInitiatedReason}
    # @!attribute campaign_id
    #   @return [Integer]
    # @!attribute product_type
    #   @return [String] {ProductType}
    # @!attribute open_id
    #   @return [String]
    # @!attribute original_order_amount
    #   @return [Integer]
    # @!attribute receipt_id
    #   @return [String]
    # @!attribute terminal_type
    #   @return [String] {TerminalType}
    # @!attribute os_type
    #   @return [String] {OsType}
    # @!attribute invoice_id
    #   @return [String]
    # @!attribute brand_name
    #   @return [String]
    # @!attribute locale
    #   @return [String]
    # @!attribute shipping_preference
    #   @return [String] {ShippingPreference}
    # @!attribute user_action
    #   @return [String] {UserAction}
    # @!attribute set_transaction_context
    #   @return [Array(Hash{String => String})]
    # @!attribute airline_data
    #   @return [Array(AirlineData)]
    # @!attribute otp_value
    #   @return [String]
    # @!attribute purchase_country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute custom_payment_method_ids
    #   @return [Array(String)]
    # @!attribute merchant_callback_url
    #   @return [String]
    # @!attribute line_of_business
    #   @return [String]
    # @!attribute shipping_delay
    #   @return [Integer]
    # @!attribute shipping_info
    #   @return [Array(CheckoutSdk::Common::ShippingInfo)]
    # @!attribute dlocal
    #   @return [DLocalProcessingSettings]
    # @!attribute senderInformation
    #   @return [SenderInformation]
    # @!attribute purpose
    #   @return [String]
    # @!attribute affiliate_id
    #   @return [string]
    # @!attribute affiliate_url
    #   @return [string]
    class ProcessingSettings
      attr_accessor :order_id,
                    :tax_amount,
                    :discount_amount,
                    :duty_amount,
                    :shipping_amount,
                    :shipping_tax_amount,
                    :aft,
                    :preferred_scheme,
                    :merchant_initiated_reason,
                    :campaign_id,
                    :product_type,
                    :open_id,
                    :original_order_amount,
                    :receipt_id,
                    :terminal_type,
                    :os_type,
                    :invoice_id,
                    :brand_name,
                    :locale,
                    :shipping_preference,
                    :user_action,
                    :set_transaction_context,
                    :airline_data,
                    :otp_value,
                    :purchase_country,
                    :custom_payment_method_ids,
                    :merchant_callback_url,
                    :line_of_business,
                    :shipping_delay,
                    :shipping_info,
                    :dlocal,
                    :senderInformation,
                    :purpose,
                    :affiliate_id,
                    :affiliate_url
    end
  end
end
