# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The type of payment on a Bacs Direct Debit instrument.
    #
    # Declared capitalized by the Bacs instrument schemas, unlike {SepaPaymentType}
    # which declares the same two concepts lowercase. The casing is not
    # interchangeable and must not be unified.
    module BacsPaymentType
      RECURRING = 'Recurring'
      REGULAR = 'Regular'
    end
  end
end
