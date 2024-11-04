# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    module AuthenticationMethod
      FEDERATED_ID = 'federated_id'
      FIDO = 'fido'
      ISSUER_CREDENTIALS = 'issuer_credentials'
      NO_AUTHENTICATION = 'no_authentication'
      OWN_CREDENTIALS = 'own_credentials'
      THIRD_PARTY_AUTHENTICATION = 'third_party_authentication'
    end
  end
end
