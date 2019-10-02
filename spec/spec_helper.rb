require "bundler/setup"
require "checkout/data/payment_request_source"
require "checkout/data/capture_payment"
require "checkout/data/refund_payment"
require "checkout/data/void_payment"
require "checkout/api_resource"
require "checkout"
require "pry"


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Checkout configuration
  config.before(:all) do
    Checkout.configure do |config|
      config.secret_key = "sk_test"
      config.public_key = "pk_test"
      config.base_url   = "https://test.com"
    end
  end
end
