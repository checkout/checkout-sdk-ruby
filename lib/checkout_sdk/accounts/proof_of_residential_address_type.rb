# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The document type accepted as a representative's proof of residential address (EEA Sole Trader Full
    # (3.0)). Same proof_of_address value as {ProofOfPrincipalAddressType}, but the API defines the two as
    # separate enums on separate documents.
    module ProofOfResidentialAddressType
      PROOF_OF_ADDRESS = 'proof_of_address'
    end
  end
end
