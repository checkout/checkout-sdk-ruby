# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for PATCH /issuing/controls/control-profiles/{controlProfileId}.
    #
    # @!attribute name
    #   @return [String]
    class UpdateControlProfileRequest
      attr_accessor :name
    end
  end
end
