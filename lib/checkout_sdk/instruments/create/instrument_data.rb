# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # @!attribute account_number
    #   @return [String]
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute payment_type
    #   @return [String] {CheckoutSdk::Payments::PaymentType}
    # @!attribute mandate_id
    #   @return [String]
    # @!attribute date_of_signature
    #   @return [DateTime]
    class InstrumentData
      attr_accessor :account_number,
                    :country,
                    :currency,
                    :payment_type,
                    :mandate_id,
                    :date_of_signature
    end
  end
end
