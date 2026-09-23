# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # The optional HTTP headers accepted when updating a card's details.
    #
    # Modelled as its own class rather than added to {CheckoutSdk::Common::Headers} because these
    # two headers belong to one endpoint, and Common::Headers is shared by every client.
    #
    # @!attribute return_encrypted_cvv
    #   Set to "true" to retrieve the card's encrypted credentials in the response. Requires an
    #   RSA public key in the Encryption-Key header, otherwise the API answers 422 with error code
    #   encryption_key_required.
    #
    #   A String rather than a boolean: the value is emitted verbatim as an HTTP header, and "true"
    #   is what the spec shows.
    #   [Optional]
    #   Maps to HTTP header return-encrypted-cvv.
    #   Example: "true"
    #   @return [String]
    # @!attribute encryption_key
    #   The RSA public key used to encrypt returned credentials. Required when
    #   return_encrypted_cvv is set. Provide the public key with the BEGIN PUBLIC KEY and END
    #   PUBLIC KEY headers and any newline characters removed, encoded as Base64.
    #   [Optional]
    #   Maps to HTTP header Encryption-Key.
    #   @return [String]
    class CardUpdateHeaders
      attr_accessor :return_encrypted_cvv, :encryption_key
    end
  end
end
