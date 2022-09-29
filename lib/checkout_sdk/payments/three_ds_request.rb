# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute enabled
    #   @return [TrueClass, FalseClass]
    # @!attribute attempt_n3d
    #   @return [TrueClass, FalseClass]
    # @!attribute eci
    #   @return [String]
    # @!attribute cryptogram
    #   @return [String]
    # @!attribute xid
    #   @return [String]
    # @!attribute version
    #   @return [String]
    # @!attribute exemption
    #   @return [String] {Exemption}
    # @!attribute challenge_indicator
    #   @return [String] {ChallengeIndicator}
    # @!attribute status
    #   @return [String]
    # @!attribute authentication_date
    #   @return [Time]
    # @!attribute authentication_amount
    #   @return [Integer]
    # @!attribute flow_type
    #   @return [String] {ThreeDSFlowType}
    # @!attribute status_reason_code
    #   @return [String]
    # @!attribute challenge_cancel_reason
    #   @return [String]
    # @!attribute score
    #   @return [String]
    # @!attribute cryptogram_algorithm
    #   @return [String]
    class ThreeDSRequest
      attr_accessor :enabled,
                    :attempt_n3d,
                    :eci,
                    :cryptogram,
                    :xid,
                    :version,
                    :exemption,
                    :challenge_indicator,
                    :status,
                    :authentication_date,
                    :authentication_amount,
                    :flow_type,
                    :status_reason_code,
                    :challenge_cancel_reason,
                    :score,
                    :cryptogram_algorithm
    end
  end
end
