require 'spec_helper'

RSpec.describe CheckoutSdk do
  it "has a version number" do
    expect(CheckoutSdk::VERSION).not_to be nil
  end

  describe "Config persistent" do
    it "has a default persistent option" do
      expect(CheckoutSdk.configuration.persistent).to be_truthy
    end

    it "allows you to change the persistent option" do
      CheckoutSdk.configure do |config|
        config.persistent = false
      end

      expect(CheckoutSdk.configuration.persistent).to be_falsy
    end
  end
end
