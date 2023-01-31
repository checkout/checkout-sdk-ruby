# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute enabled
    #   @return [TrueClass, FalseClass]
    # @!attribute device_session_id
    #   @return [String]
    class RiskRequest
      attr_accessor :enabled,
                    :device_session_id
    end
  end
end
