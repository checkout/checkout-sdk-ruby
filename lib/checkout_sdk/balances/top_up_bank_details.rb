# frozen_string_literal: true

module CheckoutSdk
  module Balances
    # The bank details for each available funding rail (swagger schema: TopUpBankDetails).
    #
    # Both `domestic` and `international` are optional, and their availability depends on the
    # sub-account's holding currency, jurisdiction, and banking partner. Do not assume that both
    # rails are always available; neither may be present.
    #
    # @!attribute domestic
    #   [Optional]
    #   @return [TopUpFundingDetails] The bank details for the domestic funding rail.
    # @!attribute international
    #   [Optional]
    #   @return [TopUpFundingDetails] The bank details for the international funding rail.
    class TopUpBankDetails
      attr_accessor :domestic,
                    :international
    end
  end
end
