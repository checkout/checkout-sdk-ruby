# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # Indicates the shipping method chosen for the transaction.
    #
    # Used by {MerchantRiskInfo#shipping_indicator}. Choose the option that accurately describes the
    # cardholder's specific transaction.
    #
    # [Optional]
    module ShippingIndicator
      BILLING_ADDRESS = 'billing_address'
      ANOTHER_ADDRESS_ON_FILE = 'another_address_on_file'
      NOT_ON_FILE = 'not_on_file'
      STORE_PICK_UP = 'store_pick_up'
      DIGITAL_GOODS = 'digital_goods'
      TRAVEL_AND_EVENT_NO_SHIPPING = 'travel_and_event_no_shipping'
      OTHER = 'other'
    end
  end
end
