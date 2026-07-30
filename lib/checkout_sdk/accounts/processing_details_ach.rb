# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # ACH-specific processing details (Accounts API v3.0). All values in minor units without decimals.
    # @!attribute annual_ach_volume
    #   @return [Integer]
    # @!attribute average_ach_transaction_size
    #   @return [Integer]
    # @!attribute estimated_monthly_credit_volume
    #   @return [Integer]
    # @!attribute average_credit_amount
    #   @return [Integer]
    class ProcessingDetailsAch
      attr_accessor :annual_ach_volume,
                    :average_ach_transaction_size,
                    :estimated_monthly_credit_volume,
                    :average_credit_amount
    end
  end
end
