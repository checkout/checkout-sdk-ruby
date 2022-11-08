# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute avs_code
    #   @return [String]
    # @!attribute cvv_result
    #   @return [String]
    class AuthorizationResult
      attr_accessor :avs_code,
                    :cvv_result
    end
  end
end
