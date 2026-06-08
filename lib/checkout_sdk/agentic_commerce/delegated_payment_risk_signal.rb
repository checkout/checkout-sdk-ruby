# frozen_string_literal: true

module CheckoutSdk
  module AgenticCommerce
    # Optional risk signal attached to a delegated payment request.
    #
    # @!attribute type
    #   @return [String] One of "card_testing", "card_takeover", "prompt_injection", etc.
    # @!attribute score
    #   @return [Integer]
    # @!attribute action_taken
    #   @return [String] e.g. "blocked", "manual_review".
    class DelegatedPaymentRiskSignal
      attr_accessor :type,
                    :score,
                    :action_taken
    end
  end
end
