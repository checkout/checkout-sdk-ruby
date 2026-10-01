# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Email addresses for this sub-entity.
    # @!attribute primary
    #   The main email address for this sub-entity.
    #   [Required]
    #   Format: email
    #   @return [String]
    class EntityEmailAddresses
      attr_accessor :primary
    end
  end
end
