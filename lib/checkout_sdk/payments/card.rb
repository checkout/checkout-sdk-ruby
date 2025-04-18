# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    # @!attribute store_payment_details
    #   @return [String] {StorePaymentDetailsType}
    class Card
      attr_accessor :account_holder,
                    :store_payment_details
    end
  end
end
