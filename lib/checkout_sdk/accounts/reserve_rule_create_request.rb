# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Request body for POST /accounts/entities/{id}/reserve-rules.
    # Extends {ReserveRuleUpdateRequest} with `valid_from`.
    #
    # @!attribute valid_from
    #   @return [String] ISO-8601 timestamp; must be at least 15 minutes in the future.
    class ReserveRuleCreateRequest < ReserveRuleUpdateRequest
      attr_accessor :valid_from
    end
  end
end
