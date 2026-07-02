# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # The type of fraud the cardholder is asserting on an Issuing dispute.
    # Maps swagger `IssuingDisputeFraudDetails.fraud_type`.
    module IssuingDisputeFraudType
      CARD_LOST = 'card_lost'
      CARD_STOLEN = 'card_stolen'
      CARD_NEVER_RECEIVED = 'card_never_received'
      FRAUDULENT_ACCOUNT = 'fraudulent_account'
      COUNTERFEIT_CARD = 'counterfeit_card'
      ACCOUNT_TAKEOVER = 'account_takeover'
      CARD_NOT_PRESENT_FRAUD = 'card_not_present_fraud'
      MERCHANT_MISREPRESENTATION = 'merchant_misrepresentation'
      CARDHOLDER_MANIPULATION = 'cardholder_manipulation'
      INCORRECT_PROCESSING = 'incorrect_processing'
      OTHER = 'other'
    end
  end
end
