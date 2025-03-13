# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    # @!attribute store_payment_details
    #   @return [String] {StorePaymentDetailsType}
    class Googlepay
      attr_accessor :account_holder,
                    :store_payment_details
    end
  end
end
