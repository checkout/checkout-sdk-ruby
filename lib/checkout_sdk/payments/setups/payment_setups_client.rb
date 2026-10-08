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
      #   :payment_methods may include :cashapp (the key is the single lowercase word `cashapp`), a Hash
      #   with the keys documented on {CashAppPaymentMethod}; you send :initialization ("disabled" or
      #   "enabled") and :customer_profile_sharing (Boolean). A Hash request is sent as is, so nested
      #   values must be Hashes too.
      #   :customer may include:
      #   - :id - The unique identifier of the customer.
      #   - :country - The two-letter ISO country code of the customer for this payment
      #     (min 2 characters, max 2 characters).
      #   - :tax_number - The customer's tax identification number.
      #   - :device - Details of the customer's device: :locale (the locale of the device),
      #     :fingerprint (a unique identifier for the customer's device), :ipv4 and :ipv6 (the
      #     customer's device IPv4 or IPv6 address, used by some payment methods for risk and
      #     eligibility checks), :client (the type of client the customer uses to initiate the
      #     payment, one of {PaymentSetupDeviceClient}; Cash App Pay requires it, although the API
      #     reference does not mark it as required) and :os (the operating system of the
      #     customer's device, one of {PaymentSetupDeviceOs}).
      # @return [Hash] The Payment Setup (swagger `PaymentSetup`, 200). For Cash App Pay, read
      #   payment_methods.cashapp.action.redirect_url, payment_methods.cashapp.reference and, once only,
      #   payment_methods.cashapp.customer_profile.
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
      #   :payment_methods may include :cashapp (the key is the single lowercase word `cashapp`), a Hash
      #   with the keys documented on {CashAppPaymentMethod}; you send :initialization ("disabled" or
      #   "enabled") and :customer_profile_sharing (Boolean). A Hash request is sent as is, so nested
      #   values must be Hashes too.
      #   :customer may include:
      #   - :id - The unique identifier of the customer.
      #   - :country - The two-letter ISO country code of the customer for this payment
      #     (min 2 characters, max 2 characters).
      #   - :tax_number - The customer's tax identification number.
      #   - :device - Details of the customer's device: :locale (the locale of the device),
      #     :fingerprint (a unique identifier for the customer's device), :ipv4 and :ipv6 (the
      #     customer's device IPv4 or IPv6 address, used by some payment methods for risk and
      #     eligibility checks), :client (the type of client the customer uses to initiate the
      #     payment, one of {PaymentSetupDeviceClient}; Cash App Pay requires it, although the API
      #     reference does not mark it as required) and :os (the operating system of the
      #     customer's device, one of {PaymentSetupDeviceOs}).
      # @return [Hash] The Payment Setup (swagger `PaymentSetup`, 200). For Cash App Pay, read
      #   payment_methods.cashapp.action.redirect_url, payment_methods.cashapp.reference and, once only,
      #   payment_methods.cashapp.customer_profile.
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
      #   payment_methods.cashapp.customer_profile.
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
      #   payment_methods.cashapp.customer_profile.
      def confirm_payment_setup(id, payment_method_name)
        api_client.invoke_post(
          build_path(PAYMENTS_PATH, SETUPS_PATH, id, CONFIRM_PATH, payment_method_name),
          sdk_authorization
        )
      end
    end
  end
end
