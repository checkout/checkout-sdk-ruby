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

    # Returns the request path in a form safe for a single log line: the query string is left out
    # and control characters are escaped.
    #
    # @param [String, nil] path
    # @return [String]
    def self.loggable_path(path)
      text = path.to_s.dup.force_encoding(Encoding::UTF_8).scrub
      text.split('?', 2).first.to_s.gsub(/[[:cntrl:]]/) { |char| char.dump[1..-2] }
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
