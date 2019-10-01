require 'spec_helper'

RSpec.describe Checkout::ApiResource do
  let(:api_resource) { Checkout::ApiResource.new }

  it "has the expected connection configuration" do
    expect(api_resource.checkout_connection.data[:host]).to eql("test.com")
  end

  describe "#request_payments" do
    let(:payment_request_source) { Checkout::PaymentRequestSource.new }
    let(:data) { { mock: true } }

    it "sends a POST request with correct params" do
      allow(payment_request_source).to receive(:data).and_return(data)

      expect(api_resource.checkout_connection).to receive(:post)
        .with({ body:"{\"mock\":true}",
                headers:{"Authorization"=>"sk_test", "Content-Type"=>"application/json"},
                path:"/payments" })

      api_resource.request_payments(payment_request_source)
    end
  end

  describe "#capture_payment" do
    let(:capture_payment) { Checkout::CapturePayment.new }

    it "sends a POST request with correct params" do
      capture_payment.id = 1

      expect(api_resource.checkout_connection).to receive(:post)
        .with({ body:"{\"amount\":null,\"reference\":null,\"metadata\":null}",
                headers:{"Authorization"=>"sk_test", "Content-Type"=>"application/json"},
                path:"/payments/1/captures" })

      api_resource.capture_payment(capture_payment)
    end
  end
end
