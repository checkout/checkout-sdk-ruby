# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Whether to process the payment as a credit or debit transaction, when a combo card is used.
    #
    # Deliberately NOT named `CardType`. The specification's values here are lowercase
    # `credit` and `debit`, while every generic card-type enum across the SDK family uses
    # `Credit`/`Debit` or `CREDIT`/`DEBIT`. .NET types this property as its generic `CardType`,
    # whose values are `Credit` and `Debit`, so it sends the wrong casing. Go avoided that by
    # adding a dedicated `ProcessingCardType`; this follows Go.
    module ProcessingCardType
      CREDIT = 'credit'
      DEBIT = 'debit'
    end
  end
end
