# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute three_ds_method_completion
    #   @return [String] {ThreeDsMethodCompletion}
    # @!attribute accept_header
    #   @return [String]
    # @!attribute java_enabled
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
                    :language,
                    :color_depth,
                    :screen_height,
                    :screen_width,
                    :timezone,
                    :user_agent,
                    :ip_address

      def initialize
        super ChannelDataType::BROWSER
      end
    end
  end
end
