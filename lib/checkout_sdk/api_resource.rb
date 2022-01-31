require "excon"
require "multi_json"

class CheckoutSdk::ApiResource
  INSTRUMENT_ENDPOINT_REGEX = %r{/(instruments|payments)\Z}.freeze

  attr_reader :checkout_connection

  def initialize
    @checkout_connection = Excon.new(
      CheckoutSdk.configuration.base_url.to_s,
      persistent: CheckoutSdk.configuration.persistent,
      read_timeout: CheckoutSdk.configuration.read_timeout,
      connect_timeout: CheckoutSdk.configuration.connect_timeout,
      write_timeout: CheckoutSdk.configuration.write_timeout
    )
  end

  # @param [Instrument] data_object
  # @return [Hash<String>]
  def create_instrument(data_object, endpoint: '/instruments')
    unless data_object.is_a?(CheckoutSdk::Instrument)
      raise ArgumentError, "Expected CheckoutSdk::Instrument, got #{data_object.class.name}"
    end

    unless INSTRUMENT_ENDPOINT_REGEX.match?(endpoint)
      raise ArgumentError, "Expected endpoint to match #{INSTRUMENT_ENDPOINT_REGEX.inspect}"
    end

    post_request('/instruments', data_object.data)
  end

  # @param [String] endpoint '/instruments' by default, can be '/payments' for card verification purposes
  # @param [String] id @see Instrument
  def get_instrument_details(id)
    get("/instruments/#{id}")
  end

  def request_payment(data_object)
    post_request("/payments", data_object.data)
  end

  def capture_payment(data_object)
    post_request("/payments/#{data_object.id}/captures", data_object.data)
  end

  def refund_payment(data_object)
    post_request("/payments/#{data_object.id}/refunds", data_object.data)
  end

  def void_payment(data_object)
    post_request("/payments/#{data_object.id}/voids", data_object.data)
  end

  def add_payment_source(data_object)
    post_request("/sources", data_object.data)
  end

  def request_token(data_object)
    post_request("/tokens", data_object.data)
  end

  def get_payment_details(id)
    get("/payments/#{id}")
  end

  def get_payment_actions(id)
    get("/payments/#{id}/actions")
  end

  private

  def post_request(path, data)
    checkout_connection.post(
      path: path,
      body: MultiJson.dump(delete_blank(data)),
      headers: { "Content-Type" => "application/json",
                 "Authorization" => key(path) }
    )
  end

  def get(path)
    checkout_connection.get(
      path: path,
      headers: { "Authorization" => secret_key_authorization_header }
    )
  end

  def key(path)
    if path == "/tokens"
      CheckoutSdk.configuration.public_key
    else
      secret_key_authorization_header
    end
  end

  def secret_key_authorization_header
    if CheckoutSdk.configuration.version == :four
      "Bearer #{CheckoutSdk.configuration.secret_key}"
    else
      CheckoutSdk.configuration.secret_key
    end
  end

  def delete_blank(data_hash)
    data_hash.delete_if do |k, v|
      (v.respond_to?(:empty?) ? v.empty? : v.nil?) or v.instance_of?(Hash) && delete_blank(v).empty?
    end
  end
end
