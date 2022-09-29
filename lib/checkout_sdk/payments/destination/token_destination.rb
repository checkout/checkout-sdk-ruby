# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute token
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class TokenDestination < Destination
      attr_accessor :token,
                    :account_holder

      def initialize
        super CheckoutSdk::Payments::DestinationType::TOKEN
      end
    end
  end
end
