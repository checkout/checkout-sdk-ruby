# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute bic
      #   @return [String]
      # @!attribute description
      #   @return [String]
      # @!attribute language
      #   @return [String]
      class IdealSource < PaymentSource
        attr_accessor :bic,
                      :description,
                      :language

        def initialize
          super CheckoutSdk::Common::PaymentSourceType::IDEAL
        end
      end
    end
  end
end
