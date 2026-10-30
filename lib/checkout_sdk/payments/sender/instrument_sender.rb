# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # An instrument sender, with type instrument: the sender information is retrieved from the payment
    # instrument (the destination, for bank payouts). Used by bank payouts and regular payments.
    # The reference is inherited from {Sender}: [Required] for bank payouts, [Optional] for regular payments.
    class InstrumentSender < Sender
      def initialize
        super(CheckoutSdk::Payments::SenderType::INSTRUMENT)
      end
    end
  end
end
