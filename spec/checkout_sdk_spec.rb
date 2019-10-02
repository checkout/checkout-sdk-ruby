require 'spec_helper'

RSpec.describe CheckoutSdk do
  it "has a version number" do
    expect(CheckoutSdk::VERSION).not_to be nil
  end
end
