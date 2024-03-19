# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [String] {CompanyVerificationType}
    # @!attribute front
    #   @return [String]
    class CompanyVerification
      attr_accessor :type,
                    :front
    end
  end
end
