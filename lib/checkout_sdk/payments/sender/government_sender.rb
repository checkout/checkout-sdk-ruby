# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute company_name
    #   @return [String]
    # @!attribute address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute reference
    #   @return [String]
    # @!attribute reference_type
    #   @return [String]
    # @!attribute source_of_funds
    #   @return [String] {SourceOfFunds}
    # @!attribute identification
    #   @return [CheckoutSdk::Common::AccountHolderIdentification]
    class GovernmentSender < Sender
      attr_accessor :company_name,
                    :address,
                    :reference,
                    :reference_type,
                    :source_of_funds,
                    :identification

      def initialize
        super(CheckoutSdk::Payments::SenderType::GOVERNMENT)
      end
    end
  end
end
