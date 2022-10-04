# frozen_string_literal: true

require 'rspec'
require 'securerandom'
require 'checkout_sdk'
require './spec/support/data_factory'
require './spec/support/sandbox_test_fixture'
require './spec/checkout_sdk/payments/payments_helper'
require './spec/checkout_sdk/sessions/sessions_helper'
require './spec/checkout_sdk/payments/previous/payments_helper'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Helpers::DataFactory
  config.include Helpers::SandboxTestFixture
end
