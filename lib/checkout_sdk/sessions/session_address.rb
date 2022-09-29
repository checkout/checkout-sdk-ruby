# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute address_line3
    #   @return [String]
    class SessionAddress < CheckoutSdk::Common::Address
      attr_accessor :address_line3
    end
  end
end
