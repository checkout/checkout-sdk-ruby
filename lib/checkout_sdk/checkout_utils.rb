# frozen_string_literal: true

module CheckoutSdk
  class CheckoutUtils
    # @return [CheckoutSdk::HttpMetadata]
    def self.map_to_http_metadata(response)
      http_metadata = CheckoutSdk::HttpMetadata.new
      return http_metadata if response.nil?

      if response.is_a?(Hash)
        http_metadata.headers = response[:headers]
        http_metadata.status_code = response[:status]
        http_metadata.body = response[:body]
      end

      if response.class.name.start_with? Faraday::Response.name
        http_metadata.headers = response.headers
        http_metadata.status_code = response.status
        http_metadata.body = response.body
      end
      http_metadata
    end

    # @return [Faraday::Connection]
    def self.build_multipart_client
      Faraday.new do |f|
        f.request :multipart
        f.response :raise_error
      end
    end

    # @return [Faraday::Connection]
    def self.build_default_client
      Faraday.new do |f|
        f.response :follow_redirects
        f.response :raise_error
      end
    end
  end
end
