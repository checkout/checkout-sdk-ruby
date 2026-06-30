# frozen_string_literal: true

module CheckoutSdk
  module StandaloneAccountUpdater
    # The source to update. Provide either `card` or `instrument`, but not both.
    #
    # @!attribute card
    #   @return [AccountUpdaterCard]
    # @!attribute instrument
    #   @return [AccountUpdaterInstrument]
    class AccountUpdaterSourceOptions
      attr_accessor :card, :instrument
    end
  end
end
