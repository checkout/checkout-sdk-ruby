# frozen_string_literal: true

module CheckoutSdk
  module NetworkTokens
    # Card-based source for provisioning a network token. Set `type = "card"`.
    #
    # @!attribute type
    #   @return [String] Always "card".
    # @!attribute number
    #   @return [String] The card number.
    # @!attribute cvv
    #   @return [String]
    # @!attribute expiry_month
    #   @return [String] 1- or 2-digit month.
    # @!attribute expiry_year
    #   @return [String] Four-digit year.
    class NetworkTokenSourceCard
      attr_accessor :type, :number, :cvv, :expiry_month, :expiry_year

      def initialize
        @type = 'card'
      end
    end
  end
end
