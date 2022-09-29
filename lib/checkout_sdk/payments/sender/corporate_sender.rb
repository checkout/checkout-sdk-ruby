# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute company_name
    #   @return [String]
    # @!attribute address
    #   @return [String] {CheckoutSdk::Common::Address}
    # @!attribute reference_type
    #   @return [String]
    # @!attribute source_of_funds
    #   @return [String] {SourceOfFunds}
    # @!attribute identification
    #   @return [CheckoutSdk::Common::AccountHolderIdentification]
    class CorporateSender < Sender
      attr_accessor :company_name,
                    :address,
                    :reference_type,
                    :source_of_funds,
                    :identification

      def initialize
        super CheckoutSdk::Payments::SenderType::CORPORATE
      end
    end
  end
end
