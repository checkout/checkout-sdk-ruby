# frozen_string_literal: true

module CheckoutSdk
  module Previous
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
      class FawrySource < PaymentSource
        attr_accessor :description,
                      :customer_profile_id,
                      :customer_email,
                      :customer_mobile,
                      :expires_on,
                      :products

        def initialize
          super(CheckoutSdk::Common::PaymentSourceType::FAWRY)
        end
      end

      # @!attribute product_id
      #   @return [String]
      # @!attribute quantity
      #   @return [Integer]
      # @!attribute price
      #   @return [Integer]
      # @!attribute description
      #   @return [String]
      class FawryProduct
        attr_accessor :product_id,
                      :quantity,
                      :price,
                      :description
      end
    end
  end
end
