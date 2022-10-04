# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute token
      #   @return [String]
      # @!attribute first_name
      #   @return [String]
      # @!attribute last_name
      #   @return [String]
      # @!attribute billing_address
      #   @return [CheckoutSdk::Common::Address]
      # @!attribute phone
      #   @return [CheckoutSdk::Common::Phone]
      class TokenDestination < Destination
        attr_accessor :token,
                      :first_name,
                      :last_name,
                      :billing_address,
                      :phone

        def initialize
          super CheckoutSdk::Payments::DestinationType::TOKEN
        end
      end
    end
  end
end
