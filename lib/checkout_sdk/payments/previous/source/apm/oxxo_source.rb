# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute integration_type
      #   @return [String] {IntegrationType}
      # @!attribute country
      #   @return [String] {CheckoutSdk::Common::Country}
      # @!attribute description
      #   @return [String]
      # @!attribute payer
      #   @return [CheckoutSdk::Payments::Payer]
      class OxxoSource < PaymentSource
        attr_accessor :integration_type,
                      :country,
                      :description,
                      :payer

        def initialize
          super CheckoutSdk::Common::PaymentSourceType::OXXO
        end
      end
    end
  end
end
