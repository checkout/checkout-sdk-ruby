# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute type
    #   @return [String] {AccountFundingTransactionIdentificationType}
    # @!attribute number
    #   @return [String]
    # @!attribute issuing_country
    #   @return [String] {CheckoutSdk::Common::Country}
    class AccountFundingTransactionIdentification
      attr_accessor :type,
                    :number,
                    :issuing_country
    end
  end
end
