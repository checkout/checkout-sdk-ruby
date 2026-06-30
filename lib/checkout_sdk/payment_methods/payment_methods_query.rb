# frozen_string_literal: true

module CheckoutSdk
  module PaymentMethods
    # Query params for GET /payment-methods.
    #
    # @!attribute processing_channel_id
    #   @return [String] (required) Pattern: ^(pc)_(\w{26})$
    class PaymentMethodsQuery
      attr_accessor :processing_channel_id
    end
  end
end
