# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute token
    #   @return [String]
    # @!attribute store_for_future_use
    #   @return [TrueClass, FalseClass]
    class TokenSource < SessionSource
      attr_accessor :token,
                    :store_for_future_use

      def initialize
        super(SessionSourceType::TOKEN)
      end
    end
  end
end
