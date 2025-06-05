# frozen_string_literal: true

module CheckoutSdk
  module Transfers
    # @!attribute transfer_type
    #   @return [String] {TransferType}
    # @!attribute source
    #   @return [TransferSource]
    # @!attribute destination
    #   @return [TransferDestination]
    # @!attribute reference
    #   @return [String]
    class CreateTransfer
      attr_accessor :transfer_type,
                    :source,
                    :destination,
                    :reference
    end
  end
end
