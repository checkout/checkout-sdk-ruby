# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute type
    #   @return [String] {AccountHolderIdentificationType}
    # @!attribute number
    #   @return [String]
    # @!attribute issuing_country
    #   @return [String] {Country}
    # @!attribute date_of_expiry
    #   @return [String]
    class AccountHolderIdentification
      attr_accessor :type,
                    :number,
                    :issuing_country,
                    :date_of_expiry
    end
  end
end
