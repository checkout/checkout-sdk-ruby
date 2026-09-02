# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Information about the account holder's details on a Swish payment source.
    #
    # @!attribute first_name
    #   @return [String] The account holder's first name. [Required]
    #     max 50 characters.
    # @!attribute last_name
    #   @return [String] The account holder's last name. [Required]
    #     max 50 characters.
    class SwishAccountHolder
      attr_accessor :first_name,
                    :last_name
    end
  end
end
