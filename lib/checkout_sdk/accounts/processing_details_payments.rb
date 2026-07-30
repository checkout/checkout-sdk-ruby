# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Payment method-specific processing details (Accounts API v3.0).
    # @!attribute ach
    #   @return [ProcessingDetailsAch]
    class ProcessingDetailsPayments
      attr_accessor :ach
    end
  end
end
