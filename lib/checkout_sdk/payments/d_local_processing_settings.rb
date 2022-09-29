# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute payer
    #   @return [Payer]
    # @!attribute installments
    #   @return [DLocalInstallments]
    class DLocalProcessingSettings
      attr_accessor :country,
                    :payer,
                    :installments
    end
  end
end
