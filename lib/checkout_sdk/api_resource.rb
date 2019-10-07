require "excon"
require "multi_json"

class CheckoutSdk::ApiResource
  attr_reader :checkout_connection

  def initialize
    @checkout_connection = Excon.new("#{CheckoutSdk.configuration.base_url}", persistent: true)
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
    post_request_public("/tokens", data_object.data)
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
                 "Authorization" => "#{CheckoutSdk.configuration.secret_key}" }
    )
  end

  def post_request_public(path, data)
    checkout_connection.post(
      path: path,
      body: MultiJson.dump(delete_blank(data)),
      headers: { "Content-Type" => "application/json",
                 "Authorization" => "#{CheckoutSdk.configuration.public_key}" }
    )
  end

  def get(path)
    checkout_connection.get(
      path: path,
      headers: { "Authorization" => "#{CheckoutSdk.configuration.secret_key}" }
    )
  end

  def delete_blank(data_hash)
    data_hash.delete_if do |k, v|
      (v.respond_to?(:empty?) ? v.empty? : !v) or v.instance_of?(Hash) && delete_blank(v).empty?
    end
  end
end
