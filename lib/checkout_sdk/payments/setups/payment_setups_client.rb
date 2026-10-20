# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Client for Payment Setups API operations
    # [Beta]
    class PaymentSetupsClient < Client
      PAYMENTS_PATH = 'payments'
      SETUPS_PATH = 'setups'
      CONFIRM_PATH = 'confirm'

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # Creates a Payment Setup.
      # To maximize the information available to the payment setup, create a Payment Setup as early as
      # possible in the customer's journey. For example, create it the first time they land on the
      # basket page.
      # [Beta]
      #
      # @param [Hash] payment_setups_request
      #   May include :billing_descriptor {PaymentSetupBillingDescriptor},
      #   :presentment_details {PaymentSetupPresentmentDetails},
      #   :terminal {PaymentSetupTerminal} and
      #   :industry {PaymentSetupIndustry} (containing :accommodation
      #   {Array(PaymentSetupAccommodation)} and :airline {Array(PaymentSetupAirline)}).
      #   A Hash request is sent as is, so every nested value must be a Hash too. To use one of the
      #   typed classes above (or {CashAppPaymentMethod}, {PayByBankPaymentMethod} or
      #   {PaymentSetupRisk}), convert it first with
      #   CheckoutSdk::JsonSerializer.to_custom_hash(object); a typed object nested directly in the
      #   Hash is not serialized and is sent as "#<CheckoutSdk::...>".
      #   :payment_methods may include :cashapp (the key is the single lowercase word `cashapp`), a Hash
      #   with the keys documented on {CashAppPaymentMethod}; you send :initialization ("disabled" or
      #   "enabled") and :customer_profile_sharing (Boolean).
      #   :payment_methods may also include :paybybank (the key is the single lowercase word
      #   `paybybank`; the API ignores `pay_by_bank` without an error), a Hash with the keys documented
      #   on {PayByBankPaymentMethod}; you send :bank_id (the identifier of the bank the customer has
      #   selected for the payment).
      #   :payment_methods may also include (every key is optional unless marked required):
      #   - :card - :token (a Hash with :id, String, the Checkout.com card token), :details (the card
      #     data: :number (String, write-only), :expiry_month (Integer), :expiry_year (Integer), :name
      #     (String, write-only), :cvv (String, write-only), :stored (Boolean, write-only) and
      #     :allow_update (Boolean)), :store_for_future_use (Boolean, write-only), :phone
      #     (:country_code, String, min 1 character, max 7 characters, and :number, String, min 6
      #     characters, max 25 characters), :account_holder (:type, one of "individual", "government"
      #     or "corporate", :first_name, :last_name, :middle_name, :company_name (Strings) and
      #     :account_name_inquiry (Boolean)) and :preferred_scheme ("visa", "mastercard" or
      #     "cartes_bancaires"). The card data goes under :details; the API ignores it at the top level
      #     of :card.
      #   - :applepay - :token_data (write-only: :version, :data and :signature (Strings) and :header,
      #     a Hash with :ephemeral_public_key, :public_key_hash and :transaction_id (Strings)), :token (a
      #     Hash with :id, String, required, pattern ^(tok)_(\w{26})$, and :expires_on, date-time,
      #     ISO 8601; a String token is not accepted), :store_for_future_use (Boolean, write-only),
      #     :phone and :account_holder as on :card, and :preferred_scheme ("visa", "mastercard" or
      #     "cartes_bancaires"). Apple Pay has no :details.
      #   - :googlepay - :token_data (write-only: :protocol_version, :signature, :signed_message and
      #     :tokenization_key (Strings)), :token, :store_for_future_use, :phone and :account_holder as
      #     on :applepay, and :preferred_scheme ("visa" or "mastercard" only). Google Pay has no
      #     :details.
      #   - :instrument - :id (String, the unique identifier of the instrument to use).
      #   - :auto_confirm - String, the payment method that automatically confirms the payment when it
      #     is ready, for example "card".
      #   :settings may include :success_url and :failure_url (String, format uri, max 255
      #   characters), :capture (Boolean, whether to capture the payment immediately, default true) and
      #   :excluded_payment_methods (Array of Strings, payment method names, for example ["klarna"]).
      #   :order may include :sub_merchants, an Array of Hashes with :id (String), :product_category
      #   (String), :number_of_sales (Integer; the API does not define number_of_trades) and
      #   :registration_date (String, format date, yyyy-MM-dd).
      #   :metadata - A Hash of key/value pairs to attach to the payment (max 20 keys); each value is a
      #   String (max 255 characters), a Number or a Boolean.
      #   :risk {PaymentSetupRisk} - Risk assessment settings for the Payment Setup: :enabled
      #   (Boolean, whether a risk assessment should be performed, default true).
      #   :customer may include:
      #   - :id - The unique identifier of the customer.
      #   - :country - The two-letter ISO country code of the customer for this payment
      #     (min 2 characters, max 2 characters).
      #   - :email - Details of the customer's email: :address (the customer's email address) and
      #     :verified (Boolean, whether the customer's email address is verified).
      #   - :name - The customer's full name (max 100 characters).
      #   - :tax_number - The customer's tax identification number.
      #   - :phone - The customer's phone number: :country_code (the international country calling
      #     code, min 1 character, max 7 characters) and :number (the phone number, min 6 characters,
      #     max 25 characters).
      #   - :merchant_account - Details of the account the customer holds with the merchant: :id,
      #     :registration_date, :last_modified, :first_transaction_date and :last_transaction_date
      #     (dates, yyyy-MM-dd), :returning_customer (Boolean), :total_order_count (Integer) and
      #     :last_payment_amount (Number).
      #   - :device - Details of the customer's device: :locale (the locale of the device),
      #     :fingerprint (a unique identifier for the customer's device), :ipv4 and :ipv6 (the
      #     customer's device IPv4 or IPv6 address, used by some payment methods for risk and
      #     eligibility checks), :client (the type of client the customer uses to initiate the
      #     payment, one of {PaymentSetupDeviceClient}; Cash App Pay requires it, although the API
      #     reference does not mark it as required) and :os (the operating system of the
      #     customer's device, one of {PaymentSetupDeviceOs}).
      # @return [Hash] The Payment Setup (swagger `PaymentSetup`, 200). For Cash App Pay, read
      #   payment_methods.cashapp.action.redirect_url, payment_methods.cashapp.reference and, once only,
      #   payment_methods.cashapp.customer_profile. For Pay by Bank, read
      #   payment_methods.paybybank.action.banks. Card, Apple Pay and Google Pay return the read-only
      #   :schemes (supported card scheme names; Google Pay never lists cartes_bancaires) and card
      #   details :last4, :bin, :scheme (Strings) and :expires_on (date-time); instrument returns the
      #   read-only :type (String) and :action (:type, "set_instrument").
      def create_payment_setup(payment_setups_request)
        api_client.invoke_post(
          build_path(PAYMENTS_PATH, SETUPS_PATH),
          sdk_authorization,
          payment_setups_request
        )
      end

      # Updates a Payment Setup.
      # Update the Payment Setup whenever there are significant changes in the data relevant to the
      # customer's transaction. For example, when the customer makes a change that impacts the total
      # payment amount.
      # [Beta]
      #
      # @param [String] id - The unique identifier of the Payment Setup to update
      # @param [Hash] payment_setups_request
      #   May include :billing_descriptor {PaymentSetupBillingDescriptor},
      #   :presentment_details {PaymentSetupPresentmentDetails},
      #   :terminal {PaymentSetupTerminal} and
      #   :industry {PaymentSetupIndustry} (containing :accommodation
      #   {Array(PaymentSetupAccommodation)} and :airline {Array(PaymentSetupAirline)}).
      #   A Hash request is sent as is, so every nested value must be a Hash too. To use one of the
      #   typed classes above (or {CashAppPaymentMethod}, {PayByBankPaymentMethod} or
      #   {PaymentSetupRisk}), convert it first with
      #   CheckoutSdk::JsonSerializer.to_custom_hash(object); a typed object nested directly in the
      #   Hash is not serialized and is sent as "#<CheckoutSdk::...>".
      #   :payment_methods may include :cashapp (the key is the single lowercase word `cashapp`), a Hash
      #   with the keys documented on {CashAppPaymentMethod}; you send :initialization ("disabled" or
      #   "enabled") and :customer_profile_sharing (Boolean).
      #   :payment_methods may also include :paybybank (the key is the single lowercase word
      #   `paybybank`; the API ignores `pay_by_bank` without an error), a Hash with the keys documented
      #   on {PayByBankPaymentMethod}; you send :bank_id (the identifier of the bank the customer has
      #   selected for the payment).
      #   :payment_methods may also include (every key is optional unless marked required):
      #   - :card - :token (a Hash with :id, String, the Checkout.com card token), :details (the card
      #     data: :number (String, write-only), :expiry_month (Integer), :expiry_year (Integer), :name
      #     (String, write-only), :cvv (String, write-only), :stored (Boolean, write-only) and
      #     :allow_update (Boolean)), :store_for_future_use (Boolean, write-only), :phone
      #     (:country_code, String, min 1 character, max 7 characters, and :number, String, min 6
      #     characters, max 25 characters), :account_holder (:type, one of "individual", "government"
      #     or "corporate", :first_name, :last_name, :middle_name, :company_name (Strings) and
      #     :account_name_inquiry (Boolean)) and :preferred_scheme ("visa", "mastercard" or
      #     "cartes_bancaires"). The card data goes under :details; the API ignores it at the top level
      #     of :card.
      #   - :applepay - :token_data (write-only: :version, :data and :signature (Strings) and :header,
      #     a Hash with :ephemeral_public_key, :public_key_hash and :transaction_id (Strings)), :token (a
      #     Hash with :id, String, required, pattern ^(tok)_(\w{26})$, and :expires_on, date-time,
      #     ISO 8601; a String token is not accepted), :store_for_future_use (Boolean, write-only),
      #     :phone and :account_holder as on :card, and :preferred_scheme ("visa", "mastercard" or
      #     "cartes_bancaires"). Apple Pay has no :details.
      #   - :googlepay - :token_data (write-only: :protocol_version, :signature, :signed_message and
      #     :tokenization_key (Strings)), :token, :store_for_future_use, :phone and :account_holder as
      #     on :applepay, and :preferred_scheme ("visa" or "mastercard" only). Google Pay has no
      #     :details.
      #   - :instrument - :id (String, the unique identifier of the instrument to use).
      #   - :auto_confirm - String, the payment method that automatically confirms the payment when it
      #     is ready, for example "card".
      #   :settings may include :success_url and :failure_url (String, format uri, max 255
      #   characters), :capture (Boolean, whether to capture the payment immediately, default true) and
      #   :excluded_payment_methods (Array of Strings, payment method names, for example ["klarna"]).
      #   :order may include :sub_merchants, an Array of Hashes with :id (String), :product_category
      #   (String), :number_of_sales (Integer; the API does not define number_of_trades) and
      #   :registration_date (String, format date, yyyy-MM-dd).
      #   :metadata - A Hash of key/value pairs to attach to the payment (max 20 keys); each value is a
      #   String (max 255 characters), a Number or a Boolean.
      #   :risk {PaymentSetupRisk} - Risk assessment settings for the Payment Setup: :enabled
      #   (Boolean, whether a risk assessment should be performed, default true).
      #   :customer may include:
      #   - :id - The unique identifier of the customer.
      #   - :country - The two-letter ISO country code of the customer for this payment
      #     (min 2 characters, max 2 characters).
      #   - :email - Details of the customer's email: :address (the customer's email address) and
      #     :verified (Boolean, whether the customer's email address is verified).
      #   - :name - The customer's full name (max 100 characters).
      #   - :tax_number - The customer's tax identification number.
      #   - :phone - The customer's phone number: :country_code (the international country calling
      #     code, min 1 character, max 7 characters) and :number (the phone number, min 6 characters,
      #     max 25 characters).
      #   - :merchant_account - Details of the account the customer holds with the merchant: :id,
      #     :registration_date, :last_modified, :first_transaction_date and :last_transaction_date
      #     (dates, yyyy-MM-dd), :returning_customer (Boolean), :total_order_count (Integer) and
      #     :last_payment_amount (Number).
      #   - :device - Details of the customer's device: :locale (the locale of the device),
      #     :fingerprint (a unique identifier for the customer's device), :ipv4 and :ipv6 (the
      #     customer's device IPv4 or IPv6 address, used by some payment methods for risk and
      #     eligibility checks), :client (the type of client the customer uses to initiate the
      #     payment, one of {PaymentSetupDeviceClient}; Cash App Pay requires it, although the API
      #     reference does not mark it as required) and :os (the operating system of the
      #     customer's device, one of {PaymentSetupDeviceOs}).
      # @return [Hash] The Payment Setup (swagger `PaymentSetup`, 200). For Cash App Pay, read
      #   payment_methods.cashapp.action.redirect_url, payment_methods.cashapp.reference and, once only,
      #   payment_methods.cashapp.customer_profile. For Pay by Bank, read
      #   payment_methods.paybybank.action.banks. Card, Apple Pay and Google Pay return the read-only
      #   :schemes (supported card scheme names; Google Pay never lists cartes_bancaires) and card
      #   details :last4, :bin, :scheme (Strings) and :expires_on (date-time); instrument returns the
      #   read-only :type (String) and :action (:type, "set_instrument").
      def update_payment_setup(id, payment_setups_request)
        api_client.invoke_put(
          build_path(PAYMENTS_PATH, SETUPS_PATH, id),
          sdk_authorization,
          payment_setups_request
        )
      end

      # Retrieves a Payment Setup by its unique identifier.
      # [Beta]
      #
      # @param [String] id - The unique identifier of the Payment Setup to retrieve
      # @return [Hash] The Payment Setup (swagger `PaymentSetup`, 200). For Cash App Pay, read
      #   payment_methods.cashapp.action.redirect_url, payment_methods.cashapp.reference and, once only,
      #   payment_methods.cashapp.customer_profile. For Pay by Bank, read
      #   payment_methods.paybybank.action.banks. Card, Apple Pay and Google Pay return the read-only
      #   :schemes (supported card scheme names; Google Pay never lists cartes_bancaires) and card
      #   details :last4, :bin, :scheme (Strings) and :expires_on (date-time); instrument returns the
      #   read-only :type (String) and :action (:type, "set_instrument").
      def get_payment_setup(id)
        api_client.invoke_get(
          build_path(PAYMENTS_PATH, SETUPS_PATH, id),
          sdk_authorization
        )
      end

      # Confirms a Payment Setup to begin processing the payment request with your chosen
      # payment method.
      # [Beta]
      #
      # @param [String] id - The unique identifier of the Payment Setup
      # @param [String] payment_method_name - The name of the payment method to process the
      #   payment with (for example, "tabby", "klarna", "card" or "cashapp")
      # @return [Hash] The Payment Setup (swagger `PaymentSetup`, 200). For Cash App Pay, read
      #   payment_methods.cashapp.action.redirect_url, payment_methods.cashapp.reference and, once only,
      #   payment_methods.cashapp.customer_profile. For Pay by Bank, read
      #   payment_methods.paybybank.action.banks. Card, Apple Pay and Google Pay return the read-only
      #   :schemes (supported card scheme names; Google Pay never lists cartes_bancaires) and card
      #   details :last4, :bin, :scheme (Strings) and :expires_on (date-time); instrument returns the
      #   read-only :type (String) and :action (:type, "set_instrument").
      def confirm_payment_setup(id, payment_method_name)
        api_client.invoke_post(
          build_path(PAYMENTS_PATH, SETUPS_PATH, id, CONFIRM_PATH, payment_method_name),
          sdk_authorization
        )
      end
    end
  end
end
