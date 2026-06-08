# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Request body for POST /entities/{entityId}/files.
    #
    # @!attribute purpose
    #   @return [String] Purpose of the file (e.g. "bank_verification").
    class EntityFilesRequest
      attr_accessor :purpose
    end
  end
end
