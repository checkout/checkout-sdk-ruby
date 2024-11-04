# frozen_string_literal: true

require 'checkout_sdk/sessions/channel/three_ds_method_completion'

module CheckoutSdk
  module Sessions
    # @!attribute three_ds_method_completion
    #   @return [String] {ThreeDsMethodCompletion}
    # @!attribute accept_header
    #   @return [String]
    # @!attribute java_enabled
    #   @return [TrueClass, FalseClass]
    # @!attribute javascript_enabled
    #   @return [TrueClass, FalseClass]
    # @!attribute language
    #   @return [String]
    # @!attribute color_depth
    #   @return [String]
    # @!attribute screen_height
    #   @return [String]
    # @!attribute screen_width
    #   @return [String]
    # @!attribute timezone
    #   @return [String]
    # @!attribute user_agent
    #   @return [String]
    # @!attribute ip_address
    #   @return [String]
    class BrowserSession < ChannelData
      attr_accessor :three_ds_method_completion,
                    :accept_header,
                    :java_enabled,
                    :javascript_enabled,
                    :language,
                    :color_depth,
                    :screen_height,
                    :screen_width,
                    :timezone,
                    :user_agent,
                    :ip_address

      def initialize(three_ds_method_completion: CheckoutSdk::Sessions::ThreeDsMethodCompletion::U)
        super ChannelDataType::BROWSER
        @three_ds_method_completion = three_ds_method_completion
      end
    end
  end
end
