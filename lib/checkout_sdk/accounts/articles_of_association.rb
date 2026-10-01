# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Memorandum or Articles of Association document.
    # @!attribute type
    #   The type of document used.
    #   [Required]
    #   @return [String] {ArticlesOfAssociationType}
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class ArticlesOfAssociation
      attr_accessor :type,
                    :front
    end
  end
end
