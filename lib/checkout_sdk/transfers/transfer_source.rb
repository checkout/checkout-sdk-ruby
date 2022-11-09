# frozen_string_literal: true

module CheckoutSdk
  module Transfers
    # @!attribute id
    #   @return [String]
    # @!attribute amount
    #   @return [Integer]
    class TransferSource
      attr_accessor :id,
                    :amount
    end
  end
end
