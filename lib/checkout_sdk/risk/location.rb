# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute latitude
    #   @return [Integer]
    # @!attribute longitude
    #   @return [Integer]
    class Location
      attr_accessor :latitude,
                    :longitude
    end
  end
end
