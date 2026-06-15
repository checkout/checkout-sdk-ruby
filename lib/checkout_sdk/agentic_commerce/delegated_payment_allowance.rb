# frozen_string_literal: true

module CheckoutSdk
  module AgenticCommerce
    # Spend-limit allowance attached to a delegated payment.
    #
    # @!attribute reason
    #   @return [String] e.g. "purchase".
    # @!attribute max_amount
    #   @return [Integer] Maximum amount in the minor currency unit.
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute checkout_session_id
    #   @return [String]
    # @!attribute merchant_id
    #   @return [String]
    # @!attribute expires_at
    #   @return [String] RFC 3339 timestamp.
    class DelegatedPaymentAllowance
      attr_accessor :reason,
                    :max_amount,
                    :currency,
                    :checkout_session_id,
                    :merchant_id,
                    :expires_at
    end
  end
end
