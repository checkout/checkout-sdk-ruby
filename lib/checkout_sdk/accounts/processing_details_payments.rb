# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Payment method-specific processing details (US ISV Seller variants).
    # @!attribute ach
    #   The ACH processing details.
    #   [Required]
    #   @return [ProcessingDetailsAch]
    class ProcessingDetailsPayments
      attr_accessor :ach
    end
  end
end
