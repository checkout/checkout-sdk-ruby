# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A token payout destination.
    #
    # @!attribute token
    #   The Checkout.com card token ID. This will be an ID with the prefix `tok_`.
    #   [Required]
    #   ^(tok)_(\w{26})$
    #   30 characters
    #   @return [String]
    # @!attribute account_holder
    #   The payout destination account holder.
    #   [Required]
    #   The type discriminates the accepted keys:
    #   - individual: type, first_name, middle_name, last_name
    #   - corporate, government: type, company_name
    #   @return [CheckoutSdk::Common::AccountHolder]
    class TokenDestination < Destination
      attr_accessor :token,
                    :account_holder

      def initialize
        super(CheckoutSdk::Payments::DestinationType::TOKEN)
      end
    end
  end
end
