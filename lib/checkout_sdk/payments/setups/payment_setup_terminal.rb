# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Terminal details.
    #
    # @!attribute id
    #   @return [String] Terminal identifier. Length: 8.
    # @!attribute local_date_time
    #   @return [String] The local date and time on the terminal, in ISO 8601 format.
    class PaymentSetupTerminal
      attr_accessor :id,
                    :local_date_time
    end
  end
end
