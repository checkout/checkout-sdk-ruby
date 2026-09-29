# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A key-and-value pair with merchant-specific data for the transaction.
    #
    # The specification describes `partner_customer_risk_data` as "an array of key-and-value
    # pairs" but declares it as a single inline object with `key` and `value`. The description and
    # the declared type disagree; this class models the declared shape, which is what the gateway
    # validates against.
    #
    # @!attribute key
    #   @return [String] The key for the pair.
    #     [Optional]
    # @!attribute value
    #   @return [String] The value for the pair.
    #     [Optional]
    class PartnerCustomerRiskData
      attr_accessor :key,
                    :value
    end
  end
end
