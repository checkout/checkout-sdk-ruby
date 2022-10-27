# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute business_registration_number
    #   @return [String]
    # @!attribute business_type
    #   @return [String] {BusinessType}
    # @!attribute legal_name
    #   @return [String]
    # @!attribute trading_name
    #   @return [String]
    # @!attribute principal_address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute registered_address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute representatives
    #   @return [Array(Representative)]
    # @!attribute document
    #   @return [EntityDocument]
    # @!attribute financial_details
    #   @return [EntityFinancialDetails]
    class Company
      attr_accessor :business_registration_number,
                    :business_type,
                    :legal_name,
                    :trading_name,
                    :principal_address,
                    :registered_address,
                    :representatives,
                    :document,
                    :financial_details
    end
  end
end
