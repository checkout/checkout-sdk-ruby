# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A payment instrument payout destination. Used by card payouts, bank payouts and unreferenced refunds.
    #
    # @!attribute id
    #   The payment source ID. This will be an ID with the prefix `src_`.
    #   [Required]
    #   ^(src)_(\w{26})$
    #   30 characters (card payout and unreferenced refund)
    #   @return [String]
    # @!attribute account_holder
    #   The payout or unreferenced refund destination account holder.
    #   [Required] for card payouts, [Optional] for unreferenced refunds.
    #   Not declared by the bank payout id destination.
    #   The type discriminates the accepted keys. For card payouts:
    #   - individual: type, first_name, middle_name, last_name
    #   - corporate, government: type, company_name
    #   For unreferenced refunds, where no name is required:
    #   - individual: type, first_name, middle_name, last_name, billing_address, phone,
    #     identification, email, date_of_birth, country_of_birth
    #   - corporate, government: type, company_name, billing_address, phone, identification, email
    #   @return [CheckoutSdk::Common::AccountHolder]
    class IdDestination < Destination
      attr_accessor :id,
                    :account_holder

      def initialize
        super(CheckoutSdk::Payments::DestinationType::ID)
      end
    end
  end
end
