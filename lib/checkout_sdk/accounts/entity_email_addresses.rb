# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Email addresses for this sub-entity.
    # @!attribute primary
    #   The main email address for this sub-entity.
    #   [Required]
    #   Format: email
    #   @return [String]
    # @!attribute pci_compliance_contact
    #   The email address of the person responsible for PCI compliance at this sub-entity.
    #   [Required] for the US ISV Seller variants (3.0), together with primary; not part of the other
    #   variants.
    #   Format: email
    #   @return [String]
    class EntityEmailAddresses
      attr_accessor :primary,
                    :pci_compliance_contact
    end
  end
end
