# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Swish source.
    #
    # @!attribute payment_country
    #   @return [String] The 2-letter ISO country code of the country in which the
    #     payment instrument is issued or operated. [Required] The schema declares
    #     one value only: SE. min 2 characters, max 2 characters.
    # @!attribute account_holder
    #   @return [SwishAccountHolder] Information about the account holder's details.
    #     [Required]
    # @!attribute billing_descriptor
    #   @return [SwishBillingDescriptor] Payment billing descriptor. [Optional]
    class SwishSource < PaymentSource
      # The only payment_country the schema declares.
      SWEDEN = 'SE'

      attr_accessor :payment_country,
                    :account_holder,
                    :billing_descriptor

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::SWISH)
      end
    end
  end
end
