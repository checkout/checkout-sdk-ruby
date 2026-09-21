# frozen_string_literal: true

module CheckoutSdk
  module Identities
    # Pagination for the list-attempts endpoints.
    #
    # Separate from {IdvAttemptAssetsQueryFilter} because the spec documents the two sets of
    # parameters against different resources: these count attempts, those count assets.
    #
    # @!attribute skip
    #   The number of attempts to skip.
    #   [Optional]
    #   Default: 0
    #   @return [Integer]
    # @!attribute limit
    #   The maximum number of attempts to return.
    #   [Optional]
    #   Default: 10
    #   @return [Integer]
    class IdvAttemptsQueryFilter
      attr_accessor :skip, :limit
    end
  end
end
