# frozen_string_literal: true

module CheckoutSdk
  module Common
    # The account holder of a payment source, an instrument, or a payout or unreferenced refund destination.
    # This class is shared by many positions; the per-position notes below cover the card payout, bank payout
    # and unreferenced refund destinations. Each position only accepts the keys its schema declares, so leave
    # the other properties unset.
    # - Card payout card and network_token destinations: type, first_name, middle_name, last_name,
    #   billing_address, phone, identification, email, date_of_birth, country_of_birth.
    # - Card payout id and token destinations: type, first_name, middle_name, last_name, company_name.
    # - Bank payout bank_account destination: type, first_name, last_name, company_name, tax_id,
    #   date_of_birth, country_of_birth, residential_status, billing_address, phone, identification.
    # - Unreferenced refund destinations: as the card payout card and network_token destinations.
    #
    # @!attribute type
    #   The type of account holder.
    #   [Required] for payout and unreferenced refund destinations (when the account holder is sent)
    #   Enum: "individual" "corporate" "government"
    #   @return [String] {AccountHolderType}
    # @!attribute full_name
    #   The account holder's full name.
    #   [Optional]
    #   @deprecated Not in the request schema of any account holder; the Klarna payment source account_holder
    #     had it until the API removed it. Still returned in the PayPal payment details source account_holder.
    #     Retained for backwards compatibility and will be removed in the next major version. There is no
    #     replacement.
    #   @return [String]
    # @!attribute first_name
    #   The account holder's legal first name. The combination of first_name, middle_name and last_name
    #   should exceed 3 letters in length for card payouts. A single character or all non-alphabetic
    #   characters return a field validation error.
    #   [Required] for individual card payout and bank payout destinations; not required for card payout id
    #   and token destinations when the name is already stored with the token or instrument; [Optional] for
    #   unreferenced refunds
    #   max 50 characters (card payouts and unreferenced refunds)
    #   @return [String]
    # @!attribute middle_name
    #   The account holder's middle name.
    #   [Optional] Card payouts and unreferenced refunds only.
    #   max 50 characters
    #   @return [String]
    # @!attribute last_name
    #   The account holder's legal last name. The combination of first_name, middle_name and last_name
    #   should exceed 3 letters in length for card payouts. A single character or all non-alphabetic
    #   characters return a field validation error.
    #   [Required] for individual card payout and bank payout destinations; not required for card payout id
    #   and token destinations when the name is already stored with the token or instrument; [Optional] for
    #   unreferenced refunds
    #   max 50 characters (card payouts and unreferenced refunds)
    #   @return [String]
    # @!attribute email
    #   The account holder's email address.
    #   [Optional] Card payout card and network_token destinations and unreferenced refunds only.
    #   max 255 characters
    #   @return [String]
    # @!attribute gender
    #   The account holder's gender.
    #   [Optional]
    #   @deprecated Not in the request schema of any account holder; the Klarna payment source account_holder
    #     had it until the API removed it. Still returned in the Klarna payment details source account_holder.
    #     Retained for backwards compatibility and will be removed in the next major version. There is no
    #     replacement.
    #   @return [String]
    # @!attribute company_name
    #   The legal name of the corporate or government account holder. A single character or all
    #   non-alphabetic characters return a field validation error.
    #   [Required] for corporate and government payout and unreferenced refund destinations
    #   max 50 characters (card payouts and unreferenced refunds)
    #   @return [String]
    # @!attribute tax_id
    #   The legal account holder's tax number or reference.
    #   [Optional] Bank payouts only.
    #   @return [String]
    # @!attribute date_of_birth
    #   The account holder's date of birth, in the format YYYY-MM-DD. Individual account holders only.
    #   [Optional]
    #   10 characters (card payouts and unreferenced refunds)
    #   @return [String]
    # @!attribute country_of_birth
    #   The account holder's country of birth, as a two-letter ISO country code. Individual account holders
    #   only.
    #   [Optional]
    #   2 characters
    #   @return [String] {Country}
    # @!attribute residential_status
    #   The account holder's residential status.
    #   [Optional] Bank payouts only.
    #   Enum: "resident" "non_resident"
    #   @return [String] {ResidentialStatusType}
    # @!attribute billing_address
    #   The account holder's billing address. For card payouts and unreferenced refunds, it is required if
    #   your company is incorporated in the United States.
    #   [Required] for individual bank payout destinations, [Optional] otherwise
    #   @return [Address]
    # @!attribute phone
    #   The account holder's phone number.
    #   [Optional] Not part of the card payout id and token destinations, nor of the corporate and
    #   government bank payout destinations.
    #   @return [Phone]
    # @!attribute identification
    #   The account holder's identification. Providing identification details for the payout recipient
    #   increases the likelihood of a successful payout.
    #   [Optional] Not part of the card payout id and token destinations, nor of the corporate and
    #   government bank payout destinations.
    #   @return [AccountHolderIdentification]
    # @!attribute account_name_inquiry
    #   Whether the ANI (account name inquiry) check should be performed with the scheme (Visa or
    #   Mastercard). Payment sources only.
    #   [Optional] Not declared by the payout or unreferenced refund destination schemas.
    #   @return [Boolean]
    class AccountHolder
      attr_accessor :type,
                    :full_name,
                    :first_name,
                    :middle_name,
                    :last_name,
                    :email,
                    :gender,
                    :company_name,
                    :tax_id,
                    :date_of_birth,
                    :country_of_birth,
                    :residential_status,
                    :billing_address,
                    :phone,
                    :identification,
                    :account_name_inquiry
    end
  end
end
