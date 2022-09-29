# frozen_string_literal: true

module CheckoutSdk
  class CheckoutSdkBuilder
    # @return [CheckoutSdk::CheckoutStaticKeysSdkBuilder]
    def static_keys
      CheckoutSdk::CheckoutStaticKeysSdkBuilder.new
    end

    # @return [CheckoutSdk::CheckoutOAuthSdkBuilder]
    def oauth
      CheckoutSdk::CheckoutOAuthSdkBuilder.new
    end

    # @return [CheckoutSdk::Previous::CheckoutPreviousSdkBuilder]
    def previous
      CheckoutSdk::Previous::CheckoutPreviousSdkBuilder.new
    end
  end
end
