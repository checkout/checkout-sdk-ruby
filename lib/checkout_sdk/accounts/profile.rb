# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute urls
    #   @return [Array(String)]
    # @!attribute mccs
    #   @return [Array(String)]
    # @!attribute default_holding_currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute holding_currencies
    #   @return [Array(CheckoutSdk::Common::Currency)]
    class Profile
      attr_accessor :urls,
                    :mccs,
                    :default_holding_currency,
                    :holding_currencies
    end
  end
end
