# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute purpose
    #   @return [String]
    # @!attribute entity_id
    #   @return [String]
    class PlatformsFile
      attr_accessor :purpose,
                    :entity_id
    end
  end
end
