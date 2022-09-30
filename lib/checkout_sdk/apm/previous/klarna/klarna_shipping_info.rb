# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Apm
      # @!attribute shipping_company
      #   @return [String]
      # @!attribute shipping_method
      #   @return [String]
      # @!attribute tracking_number
      #   @return [String]
      # @!attribute tracking_uri
      #   @return [String]
      # @!attribute return_shipping_company
      #   @return [String]
      # @!attribute return_tracking_number
      #   @return [String]
      # @!attribute return_tracking_uri
      #   @return [String]
      class KlarnaShippingInfo
        attr_accessor :shipping_company,
                      :shipping_method,
                      :tracking_number,
                      :tracking_uri,
                      :return_shipping_company,
                      :return_tracking_number,
                      :return_tracking_uri
      end
    end
  end
end
