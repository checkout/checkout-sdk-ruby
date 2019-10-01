require 'spec_helper'

RSpec.describe Checkout do
  it "has a version number" do
    expect(Checkout::VERSION).not_to be nil
  end
end
