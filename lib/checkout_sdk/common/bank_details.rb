# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute name
    #   @return [String]
    # @!attribute branch
    #   @return [String]
    # @!attribute address
    #   @return [Address]
    class BankDetails
      attr_accessor :name,
                    :branch,
                    :address
    end
  end
end
