# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # @!attribute account_holder_type
    #   @return [String] {CheckoutSdk::Common::AccountHolderType}
    # @!attribute payment_network
    #   @return [String] {PaymentNetwork}
    class BankAccountFieldQuery
      attr_accessor :account_holder_type,
                    :payment_network
    end
  end
end
