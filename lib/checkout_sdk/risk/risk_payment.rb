# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute psp
    #   @return [String]
    # @!attribute id
    #   @return [String]
    class RiskPayment
      attr_accessor :psp,
                    :id
    end
  end
end
