# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute purchase_count
    #   @return [Integer]
    # @!attribute account_age
    #   @return [String]
    # @!attribute add_card_attempts
    #   @return [Integer]
    # @!attribute shipping_address_age
    #   @return [String]
    # @!attribute account_name_matches_shipping_name
    #   @return [TrueClass, FalseClass]
    # @!attribute suspicious_account_activity
    #   @return [TrueClass, FalseClass]
    # @!attribute transactions_today
    #   @return [Integer]
    # @!attribute authentication_method
    #   @return [String] {AuthenticationMethod}
    class CardHolderAccountInfo
      attr_accessor :purchase_count,
                    :account_age,
                    :add_card_attempts,
                    :shipping_address_age,
                    :account_name_matches_shipping_name,
                    :suspicious_account_activity,
                    :transactions_today,
                    :authentication_method
    end
  end
end
