# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [ProofOfLegalityType]
    # @!attribute front
    #   @return [String]
    class ProofOfLegality
      attr_accessor :type,
                    :front
    end
  end
end
