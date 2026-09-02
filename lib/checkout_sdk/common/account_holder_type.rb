# frozen_string_literal: true

module CheckoutSdk
  module Common
    # The type of account holder.
    #
    # For stored instruments use {CheckoutSdk::Instruments::InstrumentAccountHolderType},
    # whose schemas declare individual and corporate only.
    module AccountHolderType
      INDIVIDUAL = 'individual'
      CORPORATE = 'corporate'
      GOVERNMENT = 'government'

      # Declared only by the payment and payout *sender* schemas
      # (PaymentRequestSender, PayoutSender, PaymentDetailsResponseSender), never by
      # an account-holder position. Retained rather than removed because removal is
      # breaking; prefer the sender-specific type where one exists.
      INSTRUMENT = 'instrument'
    end
  end
end
