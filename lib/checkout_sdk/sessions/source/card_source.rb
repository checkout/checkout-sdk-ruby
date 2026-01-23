# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute number
    #   @return [String]
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute name
    #   @return [String]
    # @!attribute stored
    #   @return [TrueClass, FalseClass]
    # @!attribute store_for_future_use
    #   @return [TrueClass, FalseClass]
    class CardSource < SessionSource
      attr_accessor :number,
                    :expiry_month,
                    :expiry_year,
                    :name,
                    :stored,
                    :store_for_future_use

      def initialize(stored: false)
        super(SessionSourceType::CARD)
        @stored = stored
      end
    end
  end
end
