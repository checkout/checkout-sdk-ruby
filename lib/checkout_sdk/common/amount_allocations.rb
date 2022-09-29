# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute id
    #   @return [String]
    # @!attribute amount
    #   @return [Integer]
    # @!attribute reference
    #   @return [String]
    # @!attribute commission
    #   @return [Commission]
    class AmountAllocations
      attr_accessor :id,
                    :amount,
                    :reference,
                    :commission
    end
  end
end
