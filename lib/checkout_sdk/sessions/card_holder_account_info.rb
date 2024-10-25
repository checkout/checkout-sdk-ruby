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
    #   @return [AuthenticationMethod] @deprecated This property will be removed in the future, and should not be used.
    # @!attribute cardholder_account_age_indicator
    #   @return [CheckoutSdk::Common::CardholderAccountAgeIndicatorType]
    # @!attribute account_change
    #   @return [Time]
    # @!attribute account_change_indicator
    #   @return [CheckoutSdk::Common::AccountChangeIndicatorType]
    # @!attribute account_date
    #   @return [Time]
    # @!attribute account_password_change
    #   @return [String]
    # @!attribute account_password_change_indicator
    #   @return [CheckoutSdk::Common::AccountPasswordChangeIndicatorType]
    # @!attribute transactions_per_year
    #   @return [Integer]
    # @!attribute payment_account_age
    #   @return [Time]
    # @!attribute shipping_address_usage
    #   @return [Time]
    # @!attribute account_type
    #   @return [CheckoutSdk::Common::AccountTypeCardProductType]
    # @!attribute account_id
    #   @return [String]
    # @!attribute three_ds_requestor_authentication_info
    #   @return [ThreeDsRequestorAuthenticationInfo]
    class CardholderAccountInfo
      attr_accessor :purchase_count,
                    :account_age,
                    :add_card_attempts,
                    :shipping_address_age,
                    :account_name_matches_shipping_name,
                    :suspicious_account_activity,
                    :transactions_today,
                    :authentication_method, # @deprecated
                    :cardholder_account_age_indicator,
                    :account_change,
                    :account_change_indicator,
                    :account_date,
                    :account_password_change,
                    :account_password_change_indicator,
                    :transactions_per_year,
                    :payment_account_age,
                    :shipping_address_usage,
                    :account_type,
                    :account_id,
                    :three_ds_requestor_authentication_info
    end
  end
end
