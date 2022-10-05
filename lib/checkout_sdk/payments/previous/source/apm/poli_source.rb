# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      class PoliSource < PaymentSource
        def initialize
          super CheckoutSdk::Common::PaymentSourceType::POLI
        end
      end
    end
  end
end
