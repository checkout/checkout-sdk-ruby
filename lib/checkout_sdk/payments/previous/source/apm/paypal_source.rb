# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute invoice_number
      #   @return [String]
      # @!attribute recipient_name
      #   @return [String]
      # @!attribute logo_url
      #   @return [String]
      # @!attribute stc
      #   @return [Hash(String=>String)]
      class PayPalSource < PaymentSource
        attr_accessor :invoice_number,
                      :recipient_name,
                      :logo_url,
                      :stc

        def initialize
          super(CheckoutSdk::Common::PaymentSourceType::PAYPAL)
        end
      end
    end
  end
end
