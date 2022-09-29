# frozen_string_literal: true

module CheckoutSdk
  module Previous
    class CheckoutPreviousSdkBuilder
      def static_keys
        CheckoutPreviousStaticKeysSdkBuilder.new
      end
    end
  end
end
