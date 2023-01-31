# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute reference
    #   @return [String]
    # @!attribute first_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute dob
    #   @return [String]
    # @!attribute address
    #   @return [String]
    # @!attribute city
    #   @return [String]
    # @!attribute state
    #   @return [String]
    # @!attribute country
    #   @return [String]
    # @!attribute postal_code
    #   @return [String]
    # @!attribute source_of_funds
    #   @return [String]
    # @!attribute purpose
    #     #   @return [String]
    class SenderInformation
      attr_accessor :reference,
                    :first_name,
                    :last_name,
                    :dob,
                    :address,
                    :city,
                    :state,
                    :country,
                    :postal_code,
                    :source_of_funds,
                    :purpose
    end
  end
end
