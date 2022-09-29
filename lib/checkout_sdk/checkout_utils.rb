# frozen_string_literal: true

module CheckoutSdk
  class CheckoutUtils
    # @return [CheckoutSdk::HttpMetadata]
    def self.map_to_http_metadata(response)
      metadata = CheckoutSdk::HttpMetadata.new
      # TODO: convert to hash
      metadata.headers = response[:headers]
      metadata.status_code = response[:status]
      metadata.body = response[:body]
      metadata
    end
  end
end
