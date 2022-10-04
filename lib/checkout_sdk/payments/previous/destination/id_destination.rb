# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute id
      #   @return [String]
      # @!attribute first_name
      #   @return [String]
      # @!attribute last_name
      #   @return [String]
      class IdDestination < Destination
        attr_accessor :id,
                      :first_name,
                      :last_name

        def initialize
          super CheckoutSdk::Payments::DestinationType::ID
        end
      end
    end
  end
end
