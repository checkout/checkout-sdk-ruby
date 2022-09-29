# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class InstrumentSender < Sender
      def initialize
        super CheckoutSdk::Payments::SenderType::INSTRUMENT
      end
    end
  end
end
