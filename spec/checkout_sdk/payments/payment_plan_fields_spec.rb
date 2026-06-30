# frozen_string_literal: true

RSpec.describe 'authorization_type and payment_plan request fields' do
  let(:payment_plan) do
    plan = CheckoutSdk::Payments::PaymentPlan.new
    plan.amount_variability = 'Fixed'
    plan.name = 'Monthly subscription'
    plan
  end
  let(:authorization_type) { 'Estimated' }

  shared_examples 'supports authorization_type and payment_plan' do |klass|
    it "#{klass} exposes authorization_type" do
      obj = klass.new
      obj.authorization_type = authorization_type
      expect(obj.authorization_type).to eq(authorization_type)
    end

    it "#{klass} exposes payment_plan" do
      obj = klass.new
      obj.payment_plan = payment_plan
      expect(obj.payment_plan).to eq(payment_plan)
      expect(obj.payment_plan.amount_variability).to eq('Fixed')
    end
  end

  include_examples 'supports authorization_type and payment_plan', CheckoutSdk::Payments::PaymentLink
  include_examples 'supports authorization_type and payment_plan', CheckoutSdk::Payments::HostedPaymentsSession
  include_examples 'supports authorization_type and payment_plan', CheckoutSdk::Payments::PaymentSessionsRequest
end
