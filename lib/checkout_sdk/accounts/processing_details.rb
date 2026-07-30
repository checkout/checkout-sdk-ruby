# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute settlement_country
    #   @return [String]
    # @!attribute target_countries
    #   @return [Array(String)]
    # @!attribute annual_processing_volume
    #   @return [Integer]
    # @!attribute average_transaction_value
    #   @return [Integer]
    # @!attribute average_order_fulfillment_time
    #   @return [Integer]
    # @!attribute highest_transaction_value
    #   @return [Integer]
    # @!attribute currency
    #   @return [CheckoutSdk::Common::Currency]
    # @!attribute payments
    #   @return [ProcessingDetailsPayments]
    class ProcessingDetails
      attr_accessor :settlement_country,
                    :target_countries,
                    :annual_processing_volume,
                    :average_transaction_value,
                    :average_order_fulfillment_time,
                    :highest_transaction_value,
                    :currency,
                    :payments
    end
  end
end
