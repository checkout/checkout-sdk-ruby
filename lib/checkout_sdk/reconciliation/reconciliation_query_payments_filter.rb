# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Reconciliation
      # @!attribute reference
      #   @return [String]
      # @!attribute limit
      #   @return [Integer]
      class ReconciliationQueryPaymentsFilter < CheckoutSdk::Common::DateRangeQueryFilter
        attr_accessor :reference,
                      :limit
      end
    end
  end
end
