# frozen_string_literal: true

module CheckoutSdk
  module Common
    # The type of a payment instrument.
    module InstrumentType
      BANK_ACCOUNT = 'bank_account'
      TOKEN = 'token'
      CARD = 'card'
      SEPA = 'sepa'

      # Current API (NAS) only. The previous API (ABC) instrument schemas declare
      # neither of these, so do not use them with a previous-platform client.
      ACH = 'ach'
      BACS = 'bacs'

      # Previous API (ABC) only. Not declared by any current-API instrument schema.
      CARD_TOKEN = 'card_token'
    end
  end
end
