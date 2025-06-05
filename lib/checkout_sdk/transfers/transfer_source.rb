# frozen_string_literal: true

module CheckoutSdk
  module Transfers
    # @!attribute id
    #   @return [String]
    # @!attribute amount
    #   @return [Integer]
    # @!attribute currency
    #   @return [CheckoutSdk::Common::Currency]
    class TransferSource
      attr_accessor :id,
                    :amount,
                    :currency
    end
  end
end
