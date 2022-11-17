# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Events
      # @!attribute payment_id
      #   @return [String]
      # @!attribute charge_id
      #   @return [String]
      # @!attribute track_id
      #   @return [String]
      # @!attribute reference
      #   @return [String]
      # @!attribute skip
      #   @return [Integer]
      # @!attribute limit
      #   @return [Integer]
      class EventsQueryFilter < CheckoutSdk::Common::DateRangeQueryFilter
        attr_accessor :payment_id,
                      :charge_id,
                      :track_id,
                      :reference,
                      :skip,
                      :limit
      end
    end
  end
end
