# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute type
    #   @return [String] {SessionSourceType}
    # @!attribute scheme
    #   @return [String] {SessionScheme}
    # @!attribute billing_address
    #   @return [SessionAddress]
    # @!attribute home_phone
    #   @return [CheckoutSdk::Common::Phone]
    # @!attribute mobile_phone
    #   @return [CheckoutSdk::Common::Phone]
    # @!attribute work_phone
    #   @return [CheckoutSdk::Common::Phone]
    # @!attribute email
    #   @return [String]
    class SessionSource
      attr_reader :type
      attr_accessor :scheme,
                    :billing_address,
                    :home_phone,
                    :mobile_phone,
                    :work_phone,
                    :email

      protected

      # @abstract
      # @param [String] type {SessionSourceType}
      def initialize(type)
        @type = type
      end
    end
  end
end
