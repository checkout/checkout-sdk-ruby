# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Bacs Direct Debit source.
    #
    # @!attribute id
    #   @return [String] The Bacs Direct Debit instrument ID. [Required]
    #     Pattern: ^(src)_(\w{26})$
    class BacsSource < PaymentSource
      attr_accessor :id

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::BACS)
      end
    end
  end
end
