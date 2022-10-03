# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute description
    #   @return [String]
    # @!attribute customer_profile_id
    #   @return [String]
    # @!attribute customer_email
    #   @return [String]
    # @!attribute customer_mobile
    #   @return [String]
    # @!attribute expires_on
    #   @return [Time]
    # @!attribute products
    #   @return [Array(FawryProduct)]
    class FawrySource < PaymentRequestSource
      attr_accessor :description,
                    :customer_profile_id,
                    :customer_email,
                    :customer_mobile,
                    :expires_on,
                    :products

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::FAWRY
      end
    end
  end
end
