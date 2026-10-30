# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The destination of the payout, or of the unreferenced refund.
    # You can encrypt this field by using the Cko-Encryption-Key-Id and Cko-Encrypted-Properties headers.
    #
    # @!attribute type
    #   The payout or unreferenced refund destination type. Set by each subclass.
    #   [Required]
    #   @return [String] {DestinationType}
    class Destination
      attr_reader :type

      protected

      # @abstract
      # @param [String] type {DestinationType}
      def initialize(type)
        @type = type
      end
    end
  end
end
