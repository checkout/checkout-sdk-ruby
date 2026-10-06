# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The details of the user responsible for onboarding the sub-entity.
    # @!attribute email
    #   The main email address for this sub-entity. Despite the spec's wording, this is the address of the
    #   invitee, the user responsible for onboarding the sub-entity.
    #   [Required] in the hosted onboarding invite request; [Optional] in the Full and Lite onboarding
    #   variants; not part of the US ISV Seller variants.
    #   Format: email
    #   @return [String]
    class Invitee
      attr_accessor :email
    end
  end
end
