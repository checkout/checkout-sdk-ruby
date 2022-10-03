# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Sources
      # @!attribute first_name
      #   @return [String]
      # @!attribute last_name
      #   @return [String]
      # @!attribute account_iban
      #   @return [String]
      # @!attribute bic
      #   @return [String]
      # @!attribute billing_descriptor
      #   @return [String]
      # @!attribute mandate_type
      #   @return [SourceData]
      class SourceData
        attr_accessor :first_name,
                      :last_name,
                      :account_iban,
                      :bic,
                      :billing_descriptor,
                      :mandate_type
      end
    end
  end
end
