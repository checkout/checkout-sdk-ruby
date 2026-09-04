# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The banking network used to filter the fields returned by
    # GET /validation/bank-accounts/{country}/{currency}.
    #
    # All six values are declared lowercase by the specification.
    module PaymentNetwork
      LOCAL = 'local'
      SEPA = 'sepa'
      FPS = 'fps'
      ACH = 'ach'
      FEDWIRE = 'fedwire'
      SWIFT = 'swift'
    end
  end
end
