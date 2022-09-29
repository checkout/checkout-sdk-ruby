# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute id
    #   @return [String]
    class IdSource < SessionSource
      attr_accessor :id

      def initialize
        super SessionSourceType::ID
      end
    end
  end
end
