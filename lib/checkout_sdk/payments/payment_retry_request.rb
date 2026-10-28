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
    # @!attribute max_attempts
    #   @return [Integer]
    #   @deprecated Please use {DunningRetryRequest#max_attempts} via {#dunning} instead, or
    #     {CheckoutSdk::Common::CustomerRetry#max_attempts} for customer_retry. This attribute will be
    #     removed in the next major version.
    # @!attribute end_after_day
    #   @return [Integer]
    #   @deprecated Misspelled attribute that serialized as "end_after_day", which the API does not accept.
    #     Please use {DunningRetryRequest#end_after_days} via {#dunning} instead. This attribute will be
    #     removed in the next major version.
    class PaymentRetryRequest
      attr_accessor :enabled,
                    :dunning,
                    :downtime,
                    :max_attempts,
                    :end_after_day
    end
  end
end
