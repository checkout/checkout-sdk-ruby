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
    # @!attribute iframe_payment_allowed
    #   @return [TrueClass, FalseClass] Whether the Payment API is enabled for all parent frames.
    #     Required for Google SPA support in hosted sessions.
    # @!attribute user_agent_client_hint
    #   @return [String] The raw Sec-CH-UA header value. This can improve Google SPA support.
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
                    :ip_address,
                    :iframe_payment_allowed,
                    :user_agent_client_hint

      def initialize(three_ds_method_completion: CheckoutSdk::Sessions::ThreeDsMethodCompletion::U)
        super(ChannelDataType::BROWSER)
        @three_ds_method_completion = three_ds_method_completion
      end
    end
  end
end
