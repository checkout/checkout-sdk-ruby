# frozen_string_literal: true

module CheckoutSdk
  module Disputes
    # @!attribute limit
    #   @return [Integer]
    # @!attribute skip
    #   @return [Integer]
    # @!attribute id
    #   @return [String]
    # @!attribute statuses
    #   @return [String] {DisputeStatus}
    # @!attribute payment_id
    #   @return [String]
    # @!attribute payment_reference
    #   @return [String]
    # @!attribute payment_arn
    #   @return [String]
    # @!attribute this_channel_only
    #   @return [TrueClass, FalseClass]
    # @!attribute entity_ids
    #   @return [String] - Not available on Previous.
    # @!attribute sub_entity_ids
    #   @return [String] - Not available on Previous.
    # @!attribute payment_mcc
    #   @return [String] - Not available on Previous.
    class DisputesQueryFilter < CheckoutSdk::Common::DateRangeQueryFilter
      attr_accessor :limit,
                    :skip,
                    :id,
                    :statuses,
                    :payment_id,
                    :payment_reference,
                    :payment_arn,
                    :this_channel_only,
                    :entity_ids,
                    :sub_entity_ids,
                    :payment_mcc
    end
  end
end
