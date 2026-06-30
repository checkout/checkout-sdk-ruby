# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for POST /issuing/controls/control-profiles.
    #
    # @!attribute name
    #   @return [String] Required.
    class AddControlProfileRequest
      attr_accessor :name
    end
  end
end
