# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute purpose
    #   @return [String]
    # @!attribute info_fields
    #   @return [Array(InfoFields)]
    class GiropaySource < PaymentRequestSource
      attr_accessor :purpose,
                    :info_fields

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::GIROPAY
      end
    end

    # @!attribute label
    #   @return [String]
    # @!attribute text
    #   @return [String]
    class InfoFields
      attr_accessor :label,
                    :text
    end
  end
end
