# frozen_string_literal: true

module CheckoutSdk
  module Identities
    # Pagination for the attempt-assets endpoints.
    #
    # Separate from {IdvAttemptsQueryFilter} because the spec documents the two sets of parameters
    # against different resources: these count assets, those count attempts.
    #
    # @!attribute skip
    #   The number of assets to skip.
    #   [Optional]
    #   Default: 0
    #   @return [Integer]
    # @!attribute limit
    #   The maximum number of assets to return.
    #   [Optional]
    #   Default: 10
    #   @return [Integer]
    class IdvAttemptAssetsQueryFilter
      attr_accessor :skip, :limit
    end
  end
end
