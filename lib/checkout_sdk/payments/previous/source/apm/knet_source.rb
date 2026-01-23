# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute language
      #   @return [String]
      # @!attribute user_defined_field1
      #   @return [String]
      # @!attribute user_defined_field2
      #   @return [String]
      # @!attribute user_defined_field3
      #   @return [String]
      # @!attribute user_defined_field4
      #   @return [String]
      # @!attribute user_defined_field5
      #   @return [String]
      # @!attribute card_token
      #   @return [String]
      # @!attribute ptlf
      #   @return [String]
      # @!attribute token_type
      #   @return [String]
      # @!attribute token_data
      #   @return [ApplePayTokenData]
      # @!attribute payment_method_details
      #   @return [PaymentMethodDetails]
      class KnetSource < PaymentSource
        attr_accessor :language,
                      :user_defined_field1,
                      :user_defined_field2,
                      :user_defined_field3,
                      :user_defined_field4,
                      :user_defined_field5,
                      :card_token,
                      :ptlf,
                      :token_type,
                      :token_data,
                      :payment_method_details

        def initialize
          super(CheckoutSdk::Common::PaymentSourceType::KNET)
        end
      end
    end
  end
end
