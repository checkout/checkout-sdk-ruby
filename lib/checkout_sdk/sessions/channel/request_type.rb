# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    module RequestType
      ACCOUNT_VERIFICATION = 'account_verification'
      ADD_CARD = 'add_card'
      INSTALLMENT_TRANSACTION = 'installment_transaction'
      MAIL_ORDER = 'mail_order'
      MAINTAIN_CARD_INFORMATION = 'maintain_card_information'
      OTHER_PAYMENT = 'other_payment'
      RECURRING_TRANSACTION = 'recurring_transaction'
      SPLIT_OR_DELAYED_SHIPMENT = 'split_or_delayed_shipment'
      TELEPHONE_ORDER = 'telephone_order'
      TOP_UP = 'top_up'
      WHITELIST_STATUS_CHECK = 'whitelist_status_check'
    end
  end
end
