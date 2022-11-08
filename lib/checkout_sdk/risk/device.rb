# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute ip
    #   @return [String]
    # @!attribute location
    #   @return [Location]
    # @!attribute os
    #   @return [String]
    # @!attribute type
    #   @return [String]
    # @!attribute model
    #   @return [String]
    # @!attribute date
    #   @return [DateTime]
    # @!attribute user_agent
    #   @return [String]
    # @!attribute fingerprint
    #   @return [String]
    class Device
      attr_accessor :ip,
                    :location,
                    :os,
                    :type,
                    :model,
                    :date,
                    :user_agent,
                    :fingerprint
    end
  end
end
