require 'spec_helper'

RSpec.describe CheckoutSdk::ApiResource do
  let(:api_resource) { CheckoutSdk::ApiResource.new }

  it "has the expected connection configuration" do
    expect(api_resource.checkout_connection.data[:host]).to eql("test.com")
  end

  describe "#request_payments" do
    let(:payment_request_source) { CheckoutSdk::PaymentRequestSource.new }
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
    let(:capture_payment) { CheckoutSdk::CapturePayment.new }

    it "sends a POST request with correct params" do
      capture_payment.id = 1

      expect(api_resource.checkout_connection).to receive(:post)
        .with({ body:"{\"amount\":null,\"reference\":null,\"metadata\":null}",
                headers:{"Authorization"=>"sk_test", "Content-Type"=>"application/json"},
                path:"/payments/1/captures" })

      api_resource.capture_payment(capture_payment)
    end
  end

  describe "#refund_payment" do
    let(:refund_payment) { CheckoutSdk::RefundPayment.new }

    it "sends a POST request with correct params" do
      refund_payment.id = 1

      expect(api_resource.checkout_connection).to receive(:post)
        .with({ body:"{\"amount\":null,\"reference\":null,\"metadata\":null}",
                headers:{"Authorization"=>"sk_test", "Content-Type"=>"application/json"},
                path:"/payments/1/refunds" })

      api_resource.refund_payment(refund_payment)
    end
  end

  describe "#void_payment" do
    let(:void_payment) { CheckoutSdk::VoidPayment.new }

    it "sends a POST request with correct params" do
      void_payment.id = 1

      expect(api_resource.checkout_connection).to receive(:post)
        .with({ body:"{\"reference\":null,\"metadata\":null}",
                headers:{"Authorization"=>"sk_test", "Content-Type"=>"application/json"},
                path:"/payments/1/voids" })

      api_resource.void_payment(void_payment)
    end
  end

  describe "#add_payment_source" do
    let(:payment_source) { CheckoutSdk::PaymentSource.new }
    let(:data) { { mock: true } }

    it "sends a POST request with correct params" do
      allow(payment_source).to receive(:data).and_return(data)

      expect(api_resource.checkout_connection).to receive(:post)
        .with({ body:"{\"mock\":true}",
                headers:{"Authorization"=>"sk_test", "Content-Type"=>"application/json"},
                path:"/sources" })

      api_resource.add_payment_source(payment_source)
    end
  end

  describe "#request_token" do
    let(:request_token) { CheckoutSdk::RequestToken.new }
    let(:data) { { mock: true } }

    it "sends a POST request with correct params" do
      allow(request_token).to receive(:data).and_return(data)

      expect(api_resource.checkout_connection).to receive(:post)
        .with({ body:"{\"mock\":true}",
                headers:{"Authorization"=>"sk_test", "Content-Type"=>"application/json"},
                path:"/tokens" })

      api_resource.request_token(request_token)
    end
  end

  describe "#get_payment_details" do
    let(:payment_id) { "pay_id" }

    it "sends a Get request with correct params" do
      expect(api_resource.checkout_connection).to receive(:get)
        .with({headers: {"Authorization"=>"sk_test"},
               path: "/payments/#{payment_id}"})

      api_resource.get_payment_details(payment_id)
    end
  end

  describe "#get_payment_actions" do
    let(:payment_id) { "pay_id" }

    it "sends a Get request with correct params" do
      expect(api_resource.checkout_connection).to receive(:get)
        .with({headers: {"Authorization"=>"sk_test"},
               path: "/payments/#{payment_id}/actions"})

      api_resource.get_payment_actions(payment_id)
    end
  end
end
