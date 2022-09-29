# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute country_code
    #   @return [String]
    # @!attribute number
    #   @return [String]
    class Phone
      attr_accessor :country_code,
                    :number
    end
  end
end
