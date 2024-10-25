# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute acs_transaction_id
    #   @return [String]
    # @!attribute authentication_method
    #   @return [String]
    # @!attribute authentication_timestamp
    #   @return [String]
    # @!attribute authentication_data
    #   @return [String]
    # @!attribute initial_session_id
    #   @return [String]
    class InitialTransaction
      attr_accessor :acs_transaction_id,
                    :authentication_method,
                    :authentication_timestamp,
                    :authentication_data,
                    :initial_session_id
    end
  end
end
