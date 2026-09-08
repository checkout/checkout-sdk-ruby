# frozen_string_literal: true

module CheckoutSdk
  module Balances
    # The bank details for a single funding rail (swagger schema: TopUpFundingDetails).
    #
    # `beneficiary_account_name` and `bank_name` are the only fields always returned. The
    # remaining fields vary by rail and the receiving bank's jurisdiction, and are omitted when
    # they do not apply.
    #
    # @!attribute beneficiary_account_name
    #   [Required]
    #   @return [String] The name of the account that receives the funds.
    # @!attribute beneficiary_address
    #   [Optional]
    #   @return [String] The address of the beneficiary, if the rail requires it.
    # @!attribute bank_name
    #   [Required]
    #   @return [String] The name of the bank that receives the funds.
    # @!attribute bank_address
    #   [Optional]
    #   @return [String] The address of the receiving bank, if the rail requires it.
    # @!attribute account_number
    #   [Optional]
    #   @return [String] The account number of the receiving account.
    # @!attribute sort_code
    #   [Optional]
    #   @return [String] The sort code of the receiving bank. Returned for United Kingdom
    #     domestic transfers.
    # @!attribute routing_number
    #   [Optional]
    #   @return [String] The routing number of the receiving bank. Returned for United States
    #     domestic transfers.
    # @!attribute iban
    #   [Optional]
    #   @return [String] The International Bank Account Number of the receiving account.
    # @!attribute swift_code
    #   [Optional]
    #   @return [String] The SWIFT or BIC code of the receiving bank. Returned for
    #     international transfers.
    class TopUpFundingDetails
      attr_accessor :beneficiary_account_name,
                    :beneficiary_address,
                    :bank_name,
                    :bank_address,
                    :account_number,
                    :sort_code,
                    :routing_number,
                    :iban,
                    :swift_code
    end
  end
end
