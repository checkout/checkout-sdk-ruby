# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Information about the payment aggregator.
    #
    # Maps the swagger `Aggregator` schema. Named after the schema, unlike .NET which calls its
    # equivalent `ProcessingAggregator`; Ruby has no name collision here.
    #
    # @!attribute sub_merchant_id
    #   @return [String] The sub-merchant ID.
    #     [Optional]
    #     Example: "9cf70789ba90123"
    # @!attribute aggregator_id_visa
    #   @return [String] The Visa identifier for the payment aggregator.
    #     [Optional]
    #     Example: "10012345"
    # @!attribute aggregator_id_mc
    #   @return [String] The Mastercard identifier for the payment aggregator.
    #     [Optional]
    #     Example: "00000123456"
    class Aggregator
      attr_accessor :sub_merchant_id,
                    :aggregator_id_visa,
                    :aggregator_id_mc
    end
  end
end
