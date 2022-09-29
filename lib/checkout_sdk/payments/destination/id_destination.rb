# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute id
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class IdDestination < Destination
      attr_accessor :id,
                    :account_holder

      def initialize
        super CheckoutSdk::Payments::DestinationType::ID
      end
    end
  end
end
