# frozen_string_literal: true

module CheckoutSdk
  module Financial
    # @!attribute payment_id
    #   @return [String]
    # @!attribute action_id
    #   @return [String]
    # @!attribute reference
    #   @return [String]
    # @!attribute limit
    #   @return [Integer]
    # @!attribute pagination_token
    #   @return [String]
    class FinancialActionsQuery
      attr_accessor :payment_id,
                    :action_id,
                    :reference,
                    :limit,
                    :pagination_token
    end
  end
end
