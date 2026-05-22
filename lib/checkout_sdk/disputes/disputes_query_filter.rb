# frozen_string_literal: true

module CheckoutSdk
  module Disputes
    # @!attribute limit
    #   The number of results to return.
    #   [Optional]
    #   min 1, max 250, default 50
    #   @return [Integer, nil]
    # @!attribute skip
    #   The number of results to skip.
    #   [Optional]
    #   min 0, default 0
    #   @return [Integer, nil]
    # @!attribute id
    #   The unique identifier of the dispute.
    #   [Optional]
    #   @return [String, nil]
    # @!attribute statuses
    #   One or more comma-separated statuses to filter by. Works like a logical OR.
    #   [Optional]
    #   Example: "evidence_required,evidence_under_review"
    #   @return [String, nil]
    # @!attribute payment_id
    #   The unique identifier of the payment.
    #   [Optional]
    #   @return [String, nil]
    # @!attribute payment_reference
    #   An optional reference (such as an order ID) that identifies the payment.
    #   [Optional]
    #   @return [String, nil]
    # @!attribute payment_arn
    #   The acquirer reference number (ARN).
    #   [Optional]
    #   @return [String, nil]
    # @!attribute this_channel_only
    #   If true, only returns disputes for the channel associated with the secret key.
    #   [Optional]
    #   @return [TrueClass, FalseClass, nil]
    # @!attribute entity_ids
    #   One or more comma-separated client entity IDs. Works like a logical OR.
    #   [Optional]
    #   Example: "ent_wxglze3wwywujg4nna5fb7ldli,ent_vkb5zcy64zoe3cwfmaqvqyqyku"
    #   @return [String, nil]
    # @!attribute sub_entity_ids
    #   One or more comma-separated sub-entity IDs. Works like a logical OR.
    #   [Optional]
    #   Example: "ent_uzm3uxtssvmuxnyrfdffcyjxeu,ent_hy5wtzwzeuwefmsnjtdhw4scfi"
    #   @return [String, nil]
    # @!attribute processing_channel_ids
    #   One or more comma-separated processing channel IDs. Works like a logical OR.
    #   [Optional]
    #   Example: "pc_uzm3uxtssvmuxnyrfdffcyjxeu,pc_hy5wtzwzeuwefmsnjtdhw4scfi"
    #   @return [String, nil]
    # @!attribute segment_ids
    #   One or more comma-separated segment IDs. Works like a logical OR.
    #   [Optional]
    #   @return [String, nil]
    # @!attribute payment_mcc
    #   The merchant category code (MCC) of the payment (ISO 18245).
    #   [Optional]
    #   @return [String, nil]
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
                    :processing_channel_ids,
                    :segment_ids,
                    :payment_mcc
    end
  end
end
