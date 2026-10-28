# frozen_string_literal: true

module CheckoutSdk
  module Common
    # The identification of an account holder or a sender. Shared by the card payout, bank payout,
    # unreferenced refund and regular payment positions.
    #
    # @!attribute type
    #   The type of identification.
    #   [Required] for card payout and unreferenced refund account holders and card payout senders,
    #   [Optional] for bank payout and regular payment senders and bank payout account holders
    #   Enum: "passport" "driving_license" "national_id" "company_registration" "tax_id" (card payouts and
    #   unreferenced refunds); "passport" "driving_licence" "national_id" (bank payout and regular payment
    #   senders)
    #   @return [String] {AccountHolderIdentificationType}
    # @!attribute number
    #   The identification number.
    #   [Required] for card payout and unreferenced refund account holders and card payout senders,
    #   [Optional] for bank payout and regular payment senders and bank payout account holders
    #   max 25 characters (card payout and unreferenced refund account holders)
    #   @return [String]
    # @!attribute issuing_country
    #   If applicable, the country that issued the identification, as a two-letter ISO country code.
    #   Providing it increases the likelihood of a successful identity verification.
    #   [Optional]
    #   2 characters (card payouts and unreferenced refunds)
    #   @return [String] {Country}
    # @!attribute date_of_expiry
    #   If applicable, the expiration date of the identification, in the format YYYY-MM-DD.
    #   Card payouts and unreferenced refunds only.
    #   [Optional]
    #   10 characters
    #   @return [String]
    class AccountHolderIdentification
      attr_accessor :type,
                    :number,
                    :issuing_country,
                    :date_of_expiry
    end
  end
end
