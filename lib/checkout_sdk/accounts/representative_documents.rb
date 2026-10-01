# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Verification documents for an individual representative, sent as company.representatives[].documents.
    #
    # On Accounts API v3.0 the API validates this object strictly: a key it does not recognise is rejected,
    # not ignored. These four are the only keys it accepts, and which apply depends on the variant: EEA
    # Sole Trader Full (3.0) requires identity_verification, proof_of_residential_address and
    # proof_of_registration; GB and US Sole Trader Full (3.0) require identity_verification; the EEA, GB and
    # US Company Full (3.0) variants accept identity_verification and certified_authorised_signatory, both
    # optional. The v2.0 company representatives use identity_verification only, on a non-strict object.
    #
    # Leave an attribute unset rather than assigning nil: an attribute set to nil is sent as null.
    # Company-level documents such as bank_verification belong on {OnboardSubEntityDocuments}.
    # @!attribute identity_verification
    #   The document to use to confirm the individual's identity.
    #   [Optional] (required for the sole trader full variants)
    #   @return [Document]
    # @!attribute certified_authorised_signatory
    #   Certified authorised signatory document. Required when the legal representative or other role
    #   owner is not registered on the certificate of incorporation.
    #   [Optional] (company full variants only)
    #   @return [CertifiedAuthorisedSignatory]
    # @!attribute proof_of_residential_address
    #   Proof of residential address of the representative.
    #   [Optional] (required for EEA Sole Trader Full (3.0), and only valid there)
    #   @return [ProofOfResidentialAddress]
    # @!attribute proof_of_registration
    #   Proof of the sole trader's registration, for example an extract from a trade register.
    #   [Optional] (required for EEA Sole Trader Full (3.0), and only valid there)
    #   @return [ProofOfRegistration]
    class RepresentativeDocuments
      attr_accessor :identity_verification,
                    :certified_authorised_signatory,
                    :proof_of_residential_address,
                    :proof_of_registration
    end
  end
end
