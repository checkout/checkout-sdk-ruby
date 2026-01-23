# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute billing_address
      #   @return [CheckoutSdk::Common::Address]
      # @!attribute account_holder_name
      #   @return [String]
      # @!attribute billing_descriptor
      #   @return [String]
      # @!attribute language
      #   @return [String]
      class AlmaSource < PaymentSource
        attr_accessor :billing_address

        def initialize
          super(CheckoutSdk::Common::PaymentSourceType::ALMA)
        end
      end
    end
  end
end
