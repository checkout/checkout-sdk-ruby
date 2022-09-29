# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute kty
    #   @return [String]
    # @!attribute crv
    #   @return [String]
    # @!attribute x
    #   @return [String]
    # @!attribute y
    class SdkEphemeralPublicKey
      attr_accessor :kty,
                    :crv,
                    :x,
                    :y
    end
  end
end
