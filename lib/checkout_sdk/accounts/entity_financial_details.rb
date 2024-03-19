# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute annual_processing_volume
    #   @return [Integer]
    # @!attribute average_transaction_value
    #   @return [Integer]
    # @!attribute highest_transaction_value
    #   @return [Integer]
    # @!attribute documents
    #   @return [EntityFinancialDocuments]
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    class EntityFinancialDetails
      attr_accessor :annual_processing_volume,
                    :average_transaction_value,
                    :highest_transaction_value,
                    :documents,
                    :currency
    end
  end
end
