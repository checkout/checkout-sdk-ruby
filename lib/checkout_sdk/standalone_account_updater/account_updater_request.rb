# frozen_string_literal: true

module CheckoutSdk
  module StandaloneAccountUpdater
    # Request body for POST /account-updater/cards.
    #
    # @!attribute source_options
    #   @return [AccountUpdaterSourceOptions]
    class AccountUpdaterRequest
      attr_accessor :source_options
    end
  end
end
