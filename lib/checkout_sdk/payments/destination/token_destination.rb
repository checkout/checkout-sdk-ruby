# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A token payout destination. Also the token destination of an unreferenced refund.
    #
    # @!attribute token
    #   The Checkout.com card token ID. This will be an ID with the prefix `tok_`.
    #   [Required]
    #   ^(tok)_(\w{26})$
    #   30 characters
    #   @return [String]
    # @!attribute account_holder
    #   The payout or unreferenced refund destination account holder.
    #   [Required] for card payouts, [Optional] for unreferenced refunds.
    #   The type discriminates the accepted keys. For card payouts:
    #   - individual: type, first_name, middle_name, last_name
    #   - corporate, government: type, company_name
    #   For unreferenced refunds, where no name is required:
    #   - individual: type, first_name, middle_name, last_name, billing_address, phone,
    #     identification, email, date_of_birth, country_of_birth
    #   - corporate, government: type, company_name, billing_address, phone, identification, email
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
