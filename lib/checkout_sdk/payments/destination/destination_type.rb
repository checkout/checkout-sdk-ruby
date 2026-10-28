# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The payout destination type.
    #
    # Two destination discriminators share these values:
    # - card payout destination: card, network_token, id, token
    # - bank payout destination: id, bank_account
    module DestinationType
      CARD = 'card'
      ID = 'id'
      TOKEN = 'token'
      BANK_ACCOUNT = 'bank_account'
      NETWORK_TOKEN = 'network_token'
    end
  end
end
