# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute from
    #   @return [DateTime]
    # @!attribute to
    #   @return [DateTime]
    class DateRangeQueryFilter
      attr_accessor :from,
                    :to
    end
  end
end
