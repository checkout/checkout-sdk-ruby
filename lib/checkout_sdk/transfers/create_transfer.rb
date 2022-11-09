# frozen_string_literal: true

module CheckoutSdk
  module Transfers
    # @!attribute reference
    #   @return [String]
    # @!attribute transfer_type
    #   @return [String] {TransferType}
    # @!attribute source
    #   @return [TransferSource]
    # @!attribute destination
    #   @return [TransferDestination]
    class CreateTransfer
      attr_accessor :reference,
                    :transfer_type,
                    :source,
                    :destination
    end
  end
end
