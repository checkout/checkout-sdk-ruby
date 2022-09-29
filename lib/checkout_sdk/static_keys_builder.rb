# frozen_string_literal: true

module CheckoutSdk
  class StaticKeysBuilder < AbstractCheckoutSdkBuilder
    attr_accessor :secret_key, :public_key

    # @param [String] secret_key
    def with_secret_key(secret_key)
      @secret_key = secret_key
      self
    end

    # @param [String] public_key
    def with_public_key(public_key)
      @public_key = public_key
      self
    end

    protected

    def build
      super
      validate_secret_key(@secret_key_pattern)
      validate_public_key(@public_key_pattern)
    end

    def validate_public_key(pattern)
      raise CheckoutArgumentException, 'Invalid public key' if !public_key.nil? && !public_key.match(pattern)
    end

    def validate_secret_key(pattern)
      raise CheckoutArgumentException, 'Invalid secret key' if secret_key.nil? || !secret_key.match(pattern)
    end
  end
end
