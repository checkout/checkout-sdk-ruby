# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A guest staying at the accommodation.
    #
    # @!attribute first_name
    #   @return [String] The guest's first name.
    # @!attribute last_name
    #   @return [String] The guest's last name.
    # @!attribute date_of_birth
    #   @return [String] The guest's date of birth. Format: YYYY-MM-DD.
    class PaymentSetupAccommodationGuest
      attr_accessor :first_name,
                    :last_name,
                    :date_of_birth
    end
  end
end
