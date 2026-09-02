# frozen_string_literal: true

module CheckoutSdk
  module Apm
    # Bacs Direct Debit notification request.
    #
    # @!attribute source_id
    #   @return [String] The ID of the Bacs Direct Debit instrument to notify
    #     against. [Required] Pattern: ^(src)_(\w{26})$
    # @!attribute notification_type
    #   @return [String] {BacsNotificationType} The type of pre-notification being
    #     sent to the payer. [Required]
    # @!attribute collection_date
    #   @return [String] The date the funds will be collected from the payer's
    #     account, in the format yyyy-MM-dd. [Required]
    #     Format: date - pass a yyyy-MM-dd String, not a DateTime.
    # @!attribute amount
    #   @return [Integer] The amount to be collected, in the currency's minor unit.
    #     [Required] min 1
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency} The three-letter ISO 4217
    #     currency code of the collection. [Required] min 3 characters,
    #     max 3 characters.
    # @!attribute billing_descriptor
    #   @return [String] The billing descriptor that appears on the payer's bank
    #     statement. [Required] max 25 characters.
    # @!attribute customer_email
    #   @return [String] The email address of the payer that the pre-notification is
    #     sent to. [Required] Format: email
    # @!attribute support_email
    #   @return [String] The support email address included in the pre-notification.
    #     [Required] Format: email
    # @!attribute reference
    #   @return [String] A reference you can use to identify the collection.
    #     [Optional] max 50 characters.
    # @!attribute support_phone
    #   @return [String] The support phone number included in the pre-notification,
    #     in E.164 format. [Optional]
    class BacsNotificationRequest
      attr_accessor :source_id,
                    :notification_type,
                    :collection_date,
                    :amount,
                    :currency,
                    :billing_descriptor,
                    :customer_email,
                    :support_email,
                    :reference,
                    :support_phone
    end
  end
end
