# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Seller financial questions (financial_details): on the company of EEA and US Company Full and Lite
    # (2.0), and on the individual of US Sole Trader Full and Lite (2.0).
    # @!attribute annual_processing_volume
    #   The estimated annual processing volume. In minor units without decimals.
    #   [Required] on the Full (2.0) variants; [Optional] on the Lite (2.0) variants.
    #   min 0
    #   @return [Integer]
    # @!attribute average_transaction_value
    #   The expected average transaction value. In minor units without decimals.
    #   [Required] on the Full (2.0) variants; [Optional] on the Lite (2.0) variants.
    #   min 0
    #   @return [Integer]
    # @!attribute highest_transaction_value
    #   The expected highest transaction value. In minor units without decimals.
    #   [Required] on the Full (2.0) variants; [Optional] on the Lite (2.0) variants.
    #   min 0
    #   @return [Integer]
    # @!attribute documents
    #   @deprecated Not defined by any Accounts API schema; the API does not read it. Supporting documents go on
    #     {OnboardSubEntityDocuments} instead.
    #   @return [EntityFinancialDocuments]
    # @!attribute currency
    #   The currency used for the financial details provided.
    #   [Required] on US Company Full and US Sole Trader Full (2.0); [Optional] on the other variants.
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
