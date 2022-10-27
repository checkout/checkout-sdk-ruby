# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [String]
    # @!attribute file_id
    #   @return [String]
    class EntityDocument
      attr_accessor :type,
                    :file_id
    end
  end
end
