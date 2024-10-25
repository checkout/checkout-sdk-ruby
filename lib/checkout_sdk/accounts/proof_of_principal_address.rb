# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [ProofOfPrincipalAddressType]
    # @!attribute front
    #   @return [String]
    class ProofOfPrincipalAddress
      attr_reader :type,
                  :front
    end
  end
end
