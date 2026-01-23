# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Sources
      # @!attribute billing_address
      #   @return [CheckoutSdk::Common::Address]
      # @!attribute source_data
      #   @return [SourceData]
      class SepaSourceRequest < SourceRequest
        attr_accessor :billing_address,
                      :source_data

        def initialize
          super(CheckoutSdk::Previous::Sources::SourceType::SEPA)
        end
      end
    end
  end
end
