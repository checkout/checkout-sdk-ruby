# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The Cash App payment method's details and configuration on a Payment Setup.
    # Maps swagger `CashApp`. Sent under the `payment_methods.cashapp` key (one lowercase word,
    # not `cash_app`).
    #
    # The Payment Setup request is a Hash, and a Hash request is sent as is, so do not nest an
    # instance of this class in it directly: it would not be serialized. Pass a Hash with these keys,
    # or convert an instance first:
    #   cash_app = CheckoutSdk::Payments::CashAppPaymentMethod.new
    #   cash_app.initialization = 'enabled'
    #   cash_app.customer_profile_sharing = true
    #   request[:payment_methods] = { cashapp: CheckoutSdk::JsonSerializer.to_custom_hash(cash_app) }
    # Responses are read with dot access, for example response.payment_methods.cashapp.action.redirect_url.
    class CashAppPaymentMethod
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
      # Default: "disabled"
      # Enum: "disabled" "enabled"
      # @return [String] One of {PaymentSetupPaymentMethodInitialization}.
      attr_accessor :initialization

      # Indicates whether the customer consents to share their Cash App customer profile with Checkout.com.
      # [Optional]
      # @return [TrueClass, FalseClass]
      attr_accessor :customer_profile_sharing

      # The customer's Cash App profile that they consented to share. Included in the response when
      # `customer_profile_sharing` is enabled.
      # Cash App releases this profile only once. It's present in the first successful response when you
      # get the Payment Setup after the customer authorizes the payment. Every subsequent response omits it.
      # [Optional]
      # Read only.
      # Keys (all strings, all optional):
      # - `customer_id`: Cash App's identifier for the customer. This is not a Checkout.com customer identifier.
      # - `cashtag`: The customer's $Cashtag.
      # - `reference_id`: Cash App's reference for the customer profile.
      # - `full_name`: The customer's full name.
      # - `given_name`: The customer's given name.
      # - `middle_name`: The customer's middle name.
      # - `family_name`: The customer's family name.
      # - `suffix`: The suffix of the customer's name.
      # - `birth_date`: The customer's date of birth. Format: date (the API example carries a time part,
      #   so the value is kept as a string).
      # - `address` (Hash): The customer's address, with Cash App's own key names (not the Checkout.com
      #   common address): `address_line_1` (the first line of the address), `address_line_2` (the second
      #   line of the address), `address_line_3` (the third line of the address), `locality` (the address
      #   locality, such as the city or town), `sublocality` (the address sublocality, such as the district
      #   or neighborhood), `administrative_district_level_1` (the address's top-level administrative
      #   district, such as the state or province), `postal_code` (the postal or zip code) and `country`
      #   (the address country, in ISO 3166-1 alpha-2 format, max 2 characters).
      # - `phone_number`: The customer's phone number.
      # - `email_address`: The customer's email address.
      # - `customer_since`: The date and time the customer's Cash App account was created.
      #   Format: date-time (kept as a string).
      # @return [Hash]
      attr_accessor :customer_profile

      # A reference for the Cash App Pay transaction, returned by the provider.
      # [Optional]
      # Read only.
      # max 80 characters
      # @return [String]
      attr_accessor :reference

      # The next available action for the payment method.
      # [Optional]
      # Read only.
      # Keys:
      # - `type` (String): The type of action. One of {CashAppActionType}.
      # - `redirect_url` (String): The URL to redirect the customer to so they can authorize the payment
      #   with Cash App. Format: uri
      # @return [Hash]
      attr_accessor :action
    end
  end
end
