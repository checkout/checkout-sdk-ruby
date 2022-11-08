# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute attempted
    #   @return [TrueClass, FalseClass]
    # @!attribute challenged
    #   @return [TrueClass, FalseClass]
    # @!attribute succeeded
    #   @return [TrueClass, FalseClass]
    # @!attribute liability_shifted
    #   @return [TrueClass, FalseClass]
    # @!attribute method
    #   @return [String]
    # @!attribute version
    #   @return [String]
    class AuthenticationResult
      attr_accessor :attempted,
                    :challenged,
                    :succeeded,
                    :liability_shifted,
                    :method,
                    :version
    end
  end
end
