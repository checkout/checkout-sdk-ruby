# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # Details of the device from which the authentication originated.
    #
    # @!attribute device_id
    #   @return [String] The unique identifier for the device.
    # @!attribute device_session_id
    #   @return [String] Device session ID collected from the standalone Risk.js package.
    #     Pattern: ^(dsid)_(\w{26})$
    class DeviceInformation
      attr_accessor :device_id,
                    :device_session_id
    end
  end
end
