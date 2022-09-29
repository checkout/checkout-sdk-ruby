# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute source
    #   @return [SessionSource]
    # @!attribute amount
    #   @return [Integer]
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute processing_channel_id
    #   @return [String]
    # @!attribute marketplace
    #   @return [SessionMarketplaceData]
    # @!attribute authentication_type
    #   @return [String] {AuthenticationType}
    # @!attribute authentication_category
    #   @return [String] {Category}
    # @!attribute account_info
    #   @return [CardHolderAccountInfo]
    # @!attribute challenge_indicator
    #   @return [String] {CheckoutSdk::Common::ChallengeIndicator}
    # @!attribute billing_descriptor
    #   @return [SessionsBillingDescriptor]
    # @!attribute reference
    #   @return [String]
    # @!attribute merchant_risk_info
    #   @return [MerchantRiskInfo]
    # @!attribute prior_transaction_reference
    #   @return [String]
    # @!attribute transaction_type
    #   @return [String] {TransactionType}
    # @!attribute shipping_address
    #   @return [SessionAddress]
    # @!attribute shipping_address_matches_billing
    #   @return [TrueClass, FalseClass]
    # @!attribute completion
    #   @return [CompletionInfo]
    # @!attribute channel_data
    #   @return [ChannelData]
    # @!attribute recurring
    #   @return [Recurring]
    # @!attribute installment
    #   @return [Installment]
    class SessionRequest
      attr_accessor :source,
                    :amount,
                    :currency,
                    :processing_channel_id,
                    :marketplace,
                    :authentication_type,
                    :authentication_category,
                    :account_info,
                    :challenge_indicator,
                    :billing_descriptor,
                    :reference,
                    :merchant_risk_info,
                    :prior_transaction_reference,
                    :transaction_type,
                    :shipping_address,
                    :shipping_address_matches_billing,
                    :completion,
                    :channel_data,
                    :recurring,
                    :installment
    end
  end
end
