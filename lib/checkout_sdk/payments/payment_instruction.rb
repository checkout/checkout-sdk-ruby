# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute purpose
    #   @return [String]
    # @!attribute charge_bearer
    #   @return [String] {ChargeBearer}
    # @!attribute repair
    #   @return [TrueClass, FalseClass]
    # @!attribute scheme
    #   @return [String] {InstructionScheme}
    # @!attribute quote_id
    #   @return [String]
    # @!attribute skip_expiry
    #   @return [TrueClass, FalseClass]
    # @!attribute funds_transfer_type
    #   @return [String]
    # @!attribute mvv
    #   @return [String]
    class PaymentInstruction
      attr_accessor :purpose,
                    :charge_bearer,
                    :repair,
                    :scheme,
                    :quote_id,
                    :skip_expiry,
                    :funds_transfer_type,
                    :mvv
    end
  end
end
