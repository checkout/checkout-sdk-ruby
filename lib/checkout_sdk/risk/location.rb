# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute latitude
    #   @return [String]
    # @!attribute longitude
    #   @return [String]
    class Location
      attr_accessor :latitude,
                    :longitude
    end
  end
end
