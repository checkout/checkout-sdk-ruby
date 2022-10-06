# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute phone
    #   @return [CheckoutSdk::Common::Phone]
    class BillingInformation
      attr_accessor :address,
                    :phone
    end
  end
end
