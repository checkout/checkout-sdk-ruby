# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # The optional HTTP headers accepted when updating a card's details.
    #
    # @deprecated The API no longer supports these headers; use the method without headers. Will
    #   be removed in the next major version. Headers that are set are still sent unchanged.
    #
    # Modelled as its own class rather than added to {CheckoutSdk::Common::Headers} because these
    # two headers belong to one endpoint, and Common::Headers is shared by every client.
    #
    # @!attribute return_encrypted_cvv
    #   @deprecated The API no longer supports this header; use the method without headers. Will
    #     be removed in the next major version.
    #   No longer documented by the API. Still sent unchanged as the return-encrypted-cvv HTTP
    #   header when set.
    #   [Optional]
    #   @return [String]
    # @!attribute encryption_key
    #   @deprecated The API no longer supports this header; use the method without headers. Will
    #     be removed in the next major version.
    #   No longer documented by the API. Still sent unchanged as the Encryption-Key HTTP header
    #   when set.
    #   [Optional]
    #   @return [String]
    class CardUpdateHeaders
      attr_accessor :return_encrypted_cvv, :encryption_key
    end
  end
end
