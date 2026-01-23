# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute payment_country
      #   @return [String] {CheckoutSdk::Common::Country}
      # @!attribute account_holder_name
      #   @return [String]
      # @!attribute billing_descriptor
      #   @return [String]
      class MultiBancoSource < PaymentSource
        attr_accessor :payment_country,
                      :account_holder_name,
                      :billing_descriptor

        def initialize
          super(CheckoutSdk::Common::PaymentSourceType::MULTIBANCO)
        end
      end
    end
  end
end
