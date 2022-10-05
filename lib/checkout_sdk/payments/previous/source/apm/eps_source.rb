# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute purpose
      #   @return [String]
      # @!attribute bic
      #   @return [String]
      class EPSSource < PaymentSource
        attr_accessor :purpose,
                      :bic

        def initialize
          super CheckoutSdk::Common::PaymentSourceType::EPS
        end
      end
    end
  end
end
