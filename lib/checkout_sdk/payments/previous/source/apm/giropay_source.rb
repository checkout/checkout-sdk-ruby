# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute purpose
      #   @return [String]
      # @!attribute bic
      #   @return [String]
      # @!attribute info_fieldss
      #   @return [InfoFields]
      class GiropaySource < PaymentSource
        attr_accessor :purpose,
                      :bic,
                      :info_fields

        def initialize
          super(CheckoutSdk::Common::PaymentSourceType::GIROPAY)
        end
      end

      # @!attribute label
      #   @return [String]
      # @!attribute text
      #   @return [String]
      class InfoFields
        attr_accessor :label,
                      :text
      end
    end
  end
end
