# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute quantity
      #   @return [Integer]
      # @!attribute description
      #   @return [String]
      # @!attribute language
      #   @return [String]
      # @!attribute national_id
      #   @return [String]
      class QPaySource < PaymentSource
        attr_accessor :quantity,
                      :description,
                      :language,
                      :national_id

        def initialize
          super CheckoutSdk::Common::PaymentSourceType::QPAY
        end
      end
    end
  end
end
