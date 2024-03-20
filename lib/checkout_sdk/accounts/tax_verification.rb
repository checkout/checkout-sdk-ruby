# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [String] {TaxVerificationType}
    # @!attribute front
    #   @return [String]
    class TaxVerification
      attr_accessor :type,
                    :front
    end
  end
end
