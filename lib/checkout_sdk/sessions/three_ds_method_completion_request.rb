# frozen_string_literal: true

require 'checkout_sdk/sessions/channel/three_ds_method_completion'

module CheckoutSdk
  module Sessions
    # @!attribute three_ds_method_completion
    #   @return [String] {CheckoutSdk::Sessions::Channel::ThreeDsMethodCompletion}
    class ThreeDsMethodCompletionRequest
      attr_accessor :three_ds_method_completion
    end
  end
end
