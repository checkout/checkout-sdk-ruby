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
      # To maximize the amount of information the payment setup can use, we recommend that you create
      # a payment setup as early as possible in the customer's journey. For example, the first time
      # they land on the basket page.
      # [Beta]
      #
      # @param [Hash] payment_setups_request
      def create_payment_setup(payment_setups_request)
        api_client.invoke_post(
          build_path(PAYMENTS_PATH, SETUPS_PATH),
          sdk_authorization,
          payment_setups_request
        )
      end

      # Updates a Payment Setup.
      # You should update the payment setup whenever there are significant changes in the data relevant
      # to the customer's transaction. For example, when the customer makes a change that impacts the
      # total payment amount.
      # [Beta]
      #
      # @param [String] id - The unique identifier of the Payment Setup to update
      # @param [Hash] payment_setups_request
      def update_payment_setup(id, payment_setups_request)
        api_client.invoke_put(
          build_path(PAYMENTS_PATH, SETUPS_PATH, id),
          sdk_authorization,
          payment_setups_request
        )
      end

      # Retrieves a Payment Setup.
      # [Beta]
      #
      # @param [String] id - The unique identifier of the Payment Setup to retrieve
      def get_payment_setup(id)
        api_client.invoke_get(
          build_path(PAYMENTS_PATH, SETUPS_PATH, id),
          sdk_authorization
        )
      end

      # Confirms a Payment Setup to begin processing the payment request with your chosen
      # payment method option.
      # [Beta]
      #
      # @param [String] id - The unique identifier of the Payment Setup
      # @param [String] payment_method_option_id - The unique identifier of the payment option
      # to process the payment with
      def confirm_payment_setup(id, payment_method_option_id)
        api_client.invoke_post(
          build_path(PAYMENTS_PATH, SETUPS_PATH, id, CONFIRM_PATH, payment_method_option_id),
          sdk_authorization
        )
      end
    end
  end
end
