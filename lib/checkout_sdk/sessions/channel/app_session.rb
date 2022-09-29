# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute sdk_app_id
    #   @return [String]
    # @!attribute sdk_max_timeout
    #   @return [Integer]
    # @!attribute sdk_ephem_pub_key
    #   @return [SdkEphemeralPublicKey]
    # @!attribute sdk_reference_number
    #   @return [String]
    # @!attribute sdk_encrypted_data
    #   @return [String]
    # @!attribute sdk_transaction_id
    #   @return [String]
    # @!attribute sdk_interface_type
    #   @return [String] {SdkInterfaceType}
    # @!attribute sdk_ui_elements
    #   @return [Array(UIElements)]
    class AppSession < ChannelData
      attr_accessor :sdk_app_id,
                    :sdk_max_timeout,
                    :sdk_ephem_pub_key,
                    :sdk_reference_number,
                    :sdk_encrypted_data,
                    :sdk_transaction_id,
                    :sdk_interface_type,
                    :sdk_ui_elements

      def initialize
        super ChannelDataType::APP
      end
    end
  end
end
