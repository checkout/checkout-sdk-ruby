# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The type of account holder on a stored instrument.
    #
    # The instrument schemas declare individual and corporate only, unlike
    # {CheckoutSdk::Common::AccountHolderType} which also declares government.
    module InstrumentAccountHolderType
      INDIVIDUAL = 'individual'
      CORPORATE = 'corporate'
    end
  end
end
