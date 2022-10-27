# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [String] {DocumentType}
    # @!attribute front
    #   @return [String]
    # @!attribute back
    #   @return [String]
    class Document
      attr_accessor :type,
                    :front,
                    :back
    end
  end
end
