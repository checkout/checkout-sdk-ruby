# frozen_string_literal: true

module CheckoutSdk
  module StandaloneAccountUpdater
    # Card details for the standalone Account Updater request.
    #
    # @!attribute number
    #   @return [String] The card number.
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer] Four-digit expiry year.
    class AccountUpdaterCard
      attr_accessor :number, :expiry_month, :expiry_year
    end
  end
end
