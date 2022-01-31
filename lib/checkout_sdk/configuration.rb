class CheckoutSdk::Configuration
  VERSIONS = [nil, :four].freeze

  attr_accessor :secret_key, :public_key, :base_url, :persistent, :version,
    :read_timeout, :connect_timeout, :write_timeout

  def initialize
    @secret_key = nil
    @public_key = nil
    @base_url = nil
    @persistent = true
    @version = nil
    @read_timeout = 15
    @connect_timeout = 15
    @write_timeout = 20
  end

  # Changes the SDK behavior per API version,
  # specfically tunes up the authentication headers
  # @param [Symbol] value four, nil
  def version=(value)
    unless VERSIONS.include?(value&.to_sym)
      raise ArgumentError, "Unknown version #{value}, expected either: #{VERSIONS.join(', ')}"
    end

    @version = value
  end
end
