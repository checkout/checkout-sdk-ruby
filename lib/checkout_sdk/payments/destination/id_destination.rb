# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A payment instrument payout destination. Used by both card payouts and bank payouts.
    #
    # @!attribute id
    #   The payment source ID. This will be an ID with the prefix `src_`.
    #   [Required]
    #   ^(src)_(\w{26})$
    #   30 characters (card payout)
    #   @return [String]
    # @!attribute account_holder
    #   The payout destination account holder.
    #   [Required] for card payouts. Not declared by the bank payout id destination.
    #   The type discriminates the accepted keys:
    #   - individual: type, first_name, middle_name, last_name
    #   - corporate, government: type, company_name
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
