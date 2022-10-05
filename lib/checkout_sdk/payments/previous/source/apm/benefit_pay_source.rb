# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute integration_type
      #   @return [String] {IntegrationType}
      class BenefitPaySource < PaymentSource
        attr_accessor :integration_type

        def initialize
          super CheckoutSdk::Common::PaymentSourceType::BENEFITPAY
        end
      end
    end
  end
end
