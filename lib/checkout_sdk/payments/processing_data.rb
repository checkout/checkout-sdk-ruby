# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Response-side `processing` object returned alongside payment responses.
    # Distinct from {ProcessingSettings} which is the request-side equivalent.
    #
    # Mirrors the swagger ProcessingData schema:
    #   preferred_scheme, app_id, partner_*, tax_amount, locale, retrieval_reference_number,
    #   cko_network_token_available (SDK-only), aft, merchant_category_code, scheme_merchant_id,
    #   pan_type_processed, fallback_source_used, failure_code, partner_code, partner_response_code,
    #   scheme, partner_fraud_status, partner_merchant_advice_code, accommodation_data, airline_data,
    #   custom_payment_method_ids
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
                    :airline_data
    end
  end
end
