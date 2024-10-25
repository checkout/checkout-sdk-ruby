# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [ShareholderStructureType]
    # @!attribute front
    #   @return [String]
    class ShareholderStructure
      attr_accessor :type,
                    :front
    end
  end
end
