require "excon"

class Checkout::ApiResource
  attr_reader :checkout_connection

  def initialize
    @checkout_connection = Excon.new("#{Checkout.configuration.base_url}", persistent: true)
  end

  def request_payments(data_object)
    post_request("/payments", data_object.data)
  end

  def capture_payment(data_object)
    post_request("/payments/#{data_object.id}/captures", data_object.data)
  end

  private

  def post_request(path, data_object)
    checkout_connection.post(
      path: path,
      body: data_object.to_json,
      headers: { "Content-Type" => "application/json",
                 "Authorization" => "#{Checkout.configuration.secret_key}" }
    )
  end
end
