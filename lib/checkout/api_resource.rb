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

  def refund_payment(data_object)
    post_request("/payments/#{data_object.id}/refunds", data_object.data)
  end

  def void_payment(data_object)
    post_request("/payments/#{data_object.id}/voids", data_object.data)
  end

  def add_payment_source(data_object)
    post_request("/sources", data_object.data)
  end

  def get_payment_details(id)
    get("/payments/#{id}")
  end

  def get_payment_actions(id)
    get("/payments/#{id}/actions")
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

  def get(path)
    checkout_connection.get(
      path: path,
      headers: { "Authorization" => "#{Checkout.configuration.secret_key}" }
    )
  end

end
