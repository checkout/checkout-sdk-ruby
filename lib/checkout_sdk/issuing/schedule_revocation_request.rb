# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for POST /issuing/cards/{cardId}/schedule-revocation.
    #
    # @!attribute revocation_date
    #   @return [String] ISO-8601 date the card revocation should take effect.
    class ScheduleRevocationRequest
      attr_accessor :revocation_date
    end
  end
end
