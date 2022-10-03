# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Sources
      # @!attribute type
      #   @return [String] {SourceType}
      # @!attribute reference
      #   @return [String]
      # @!attribute phone
      #   @return [CheckoutSdk::Common::Phone]
      # @!attribute customer
      #   @return [CheckoutSdk::Common::Customer]
      class SourceRequest
        attr_reader :type
        attr_accessor :reference,
                      :phone,
                      :customer

        protected

        # @abstract
        # @param [String]  {SourceType}
        def initialize(type)
          @type = type
        end
      end
    end
  end
end
