# frozen_string_literal: true

module CheckoutSdk
  module Common
    # The type of a payment instrument.
    module InstrumentType
      BANK_ACCOUNT = 'bank_account'
      TOKEN = 'token'
      CARD = 'card'
      SEPA = 'sepa'
      ACH = 'ach'
      BACS = 'bacs'

      # Previous API (ABC) only. Not declared by any current-API instrument schema.
      CARD_TOKEN = 'card_token'
    end
  end
end
