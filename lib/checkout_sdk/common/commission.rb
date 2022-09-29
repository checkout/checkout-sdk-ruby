# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute amount
    #   @return [Integer]
    # @!attribute percentage
    #   @return [Integer]
    class Commission
      attr_accessor :amount,
                    :percentage
    end
  end
end
