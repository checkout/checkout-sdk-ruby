# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute first_name
    #   @return [String]
    # @!attribute middle_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute dob
    #   @return [String]
    # @!attribute address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute identification
    #   @return [CheckoutSdk::Common::AccountHolderIdentification]
    # @!attribute reference_type
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [String]
    # @!attribute source_of_funds
    #   @return [String] {SourceOfFunds}
    # @!attribute country_of_birth
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute nationality
    #   @return [String] {CheckoutSdk::Common::Country}
    class IndividualSender < Sender
      attr_accessor :first_name,
                    :middle_name,
                    :last_name,
                    :dob,
                    :address,
                    :identification,
                    :reference_type,
                    :date_of_birth,
                    :source_of_funds,
                    :country_of_birth,
                    :nationality

      def initialize
        super CheckoutSdk::Payments::SenderType::INDIVIDUAL
      end
    end
  end
end
