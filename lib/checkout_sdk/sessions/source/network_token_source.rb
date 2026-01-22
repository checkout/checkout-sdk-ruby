# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute token
    #   @return [String]
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute name
    #   @return [String]
    # @!attribute stored
    #   @return [TrueClass, FalseClass]
    class NetworkTokenSource < SessionSource
      attr_accessor :token,
                    :expiry_month,
                    :expiry_year,
                    :name,
                    :stored

      def initialize
        super(SessionSourceType::NETWORK_TOKEN)
      end
    end
  end
end
