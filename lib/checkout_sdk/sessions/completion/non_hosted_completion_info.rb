# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute callback_url
    #   @return [String]
    class NonHostedCompletionInfo < CompletionInfo
      attr_accessor :callback_url

      def initialize
        super CompletionInfoType::NON_HOSTED
      end
    end
  end
end
