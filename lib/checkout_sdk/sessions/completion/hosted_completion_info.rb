# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute callback_url
    #   @return [String]
    # @!attribute success_url
    #   @return [String]
    # @!attribute failure_url
    #   @return [String]
    class HostedCompletionInfo < CompletionInfo
      attr_accessor :callback_url,
                    :success_url,
                    :failure_url

      def initialize
        super(CompletionInfoType::HOSTED)
      end
    end
  end
end
