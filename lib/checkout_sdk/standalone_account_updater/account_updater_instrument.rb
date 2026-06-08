# frozen_string_literal: true

module CheckoutSdk
  module StandaloneAccountUpdater
    # Instrument reference for the standalone Account Updater request.
    #
    # @!attribute id
    #   @return [String] Unique instrument identifier (e.g. "src_...").
    class AccountUpdaterInstrument
      attr_accessor :id
    end
  end
end
