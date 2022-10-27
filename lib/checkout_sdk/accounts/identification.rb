# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute national_id_number
    #   @return [String]
    # @!attribute document
    #   @return [Document]
    class Identification
      attr_accessor :national_id_number,
                    :document
    end
  end
end
