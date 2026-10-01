# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The expected ACH processing (US ISV Seller variants). All amounts are in minor units without
    # decimals.
    # @!attribute annual_ach_volume
    #   The estimated annual ACH processing volume.
    #   [Required]
    #   min 0
    #   @return [Integer]
    # @!attribute average_ach_transaction_size
    #   The expected average ACH transaction size.
    #   [Required]
    #   min 0
    #   @return [Integer]
    # @!attribute estimated_monthly_credit_volume
    #   The estimated monthly volume of ACH credit transactions (for example, refunds issued to customers).
    #   [Required]
    #   min 0
    #   @return [Integer]
    # @!attribute average_credit_amount
    #   The average value of an ACH credit transaction (for example, a refund).
    #   [Required]
    #   min 0
    #   @return [Integer]
    class ProcessingDetailsAch
      attr_accessor :annual_ach_volume,
                    :average_ach_transaction_size,
                    :estimated_monthly_credit_volume,
                    :average_credit_amount
    end
  end
end
