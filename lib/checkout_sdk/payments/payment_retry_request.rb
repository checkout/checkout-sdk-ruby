# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Configuration of asynchronous retries (POST /payments).
    #
    # @!attribute enabled
    #   @return [TrueClass, FalseClass] [Required] Indicates whether asynchronous retries are enabled for the payment.
    # @!attribute dunning
    #   @return [DunningRetryRequest] [Optional] Configuration of asynchronous Dunning retries.
    # @!attribute downtime
    #   @return [DowntimeRetryRequest] [Optional] Configuration of asynchronous Downtime retries.
    class PaymentRetryRequest
      attr_accessor :enabled,
                    :dunning,
                    :downtime
    end
  end
end
