# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute three_ds_req_auth_method
    #   @return [String] {ThreeDsReqAuthMethod}
    # @!attribute three_ds_req_auth_timestamp
    #   @return [Time]
    # @!attribute three_ds_req_auth_data
    #   @return [String]
    class ThreeDsRequestorAuthenticationInfo
      attr_accessor :three_ds_req_auth_method,
                    :three_ds_req_auth_timestamp,
                    :three_ds_req_auth_data
    end
  end
end
