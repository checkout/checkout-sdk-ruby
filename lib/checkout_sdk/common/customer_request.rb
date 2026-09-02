# frozen_string_literal: true

module CheckoutSdk
  module Common
    # The customer's details.
    #
    # This type serves two positions with different property sets. The payments
    # position (swagger `CustomerRequest`) declares all six properties below. The
    # instrument position (swagger `StoreCustomerInstrumentRequest`, used by
    # {CheckoutSdk::Instruments::InstrumentBacs}, {CheckoutSdk::Instruments::InstrumentSepa}
    # and {CheckoutSdk::Instruments::InstrumentAch}) declares every property except
    # tax_number - do not send tax_number when storing an instrument.
    #
    # @!attribute id
    #   @return [String]
    # @!attribute email
    #   @return [String]
    # @!attribute name
    #   @return [String] Only sets the name for *new* customers.
    # @!attribute tax_number
    #   @return [String] Payments position only. Not declared by
    #     StoreCustomerInstrumentRequest.
    # @!attribute phone
    #   @return [Phone]
    # @!attribute default
    #   @return [TrueClass, FalseClass] If true, this instrument becomes the default
    #     for the customer. An instrument is automatically the default when the
    #     request creates a new customer.
    class CustomerRequest
      attr_accessor :id,
                    :email,
                    :name,
                    :tax_number,
                    :phone,
                    :default
    end
  end
end
