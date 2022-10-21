# frozen_string_literal: true

module CheckoutSdk
  module Reports
    # @!attribute created_after
    #   @return [DateTime]
    # @!attribute created_before
    #   @return [DateTime]
    # @!attribute entity_id
    #   @return [String]
    # @!attribute limit
    #   @return [Integer]
    # @!attribute pagination_token
    #   @return [String]
    class ReportsQuery
      attr_accessor :created_after,
                    :created_before,
                    :entity_id,
                    :limit,
                    :pagination_token
    end
  end
end
