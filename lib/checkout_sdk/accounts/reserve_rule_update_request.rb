# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Request body for PUT /accounts/entities/{entityId}/reserve-rules/{id}.
    #
    # @!attribute type
    #   @return [String] Reserve rule type (e.g. "rolling").
    # @!attribute rolling
    #   @return [RollingReserveRule]
    class ReserveRuleUpdateRequest
      attr_accessor :type, :rolling
    end
  end
end
