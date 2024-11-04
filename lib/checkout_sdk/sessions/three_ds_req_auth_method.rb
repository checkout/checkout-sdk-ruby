# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    module ThreeDsReqAuthMethod
      NO_THREEDS_REQUESTOR_AUTHENTICATION_OCCURRED = 'no_threeds_requestor_authentication_occurred'
      THREE3DS_REQUESTOR_OWN_CREDENTIALS = 'three3ds_requestor_own_credentials'
      FEDERATED_ID = 'federated_id'
      ISSUER_CREDENTIALS = 'issuer_credentials'
      THIRD_PARTY_AUTHENTICATION = 'third_party_authentication'
      FIDO_AUTHENTICATOR = 'fido_authenticator'
      FIDO_AUTHENTICATOR_FIDO_ASSURANCE_DATA_SIGNED = 'fido_authenticator_fido_assurance_data_signed'
      SRC_ASSURANCE_DATA = 'src_assurance_data'
    end
  end
end
