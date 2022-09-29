# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    module AuthenticationMethod
      NO_AUTHENTICATION = 'no_authentication'
      OWN_CREDENTIALS = 'own_credentials'
      FEDERATED_ID = 'federated_id'
      ISSUER_CREDENTIALS = 'issuer_credentials'
      THIRD_PARTY_AUTHENTICATION = 'third_party_authentication'
      FIDO = 'fido'
    end
  end
end
