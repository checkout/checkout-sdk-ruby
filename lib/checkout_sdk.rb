# frozen_string_literal: true

# Commons
require 'time'
require 'json'
require 'faraday'
require 'faraday/multipart'
require 'faraday/net_http'
require 'faraday/follow_redirects'
require 'mime/types'
require 'logger'
require 'ostruct'

# Version
require 'checkout_sdk/version'

# Configuration
require 'checkout_sdk/error'
require 'checkout_sdk/json_serializer'
require 'checkout_sdk/http_metadata'
require 'checkout_sdk/checkout_utils'
require 'checkout_sdk/platform_type'
require 'checkout_sdk/environment'
require 'checkout_sdk/environment_subdomain'
require 'checkout_sdk/sdk_credentials'
require 'checkout_sdk/sdk_authorization'
require 'checkout_sdk/static_keys_sdk_credentials'
require 'checkout_sdk/checkout_configuration'
require 'checkout_sdk/authorization_type'
require 'checkout_sdk/client'
require 'checkout_sdk/api_client'
require 'checkout_sdk/abstract_checkout_sdk_builder'
require 'checkout_sdk/static_keys_builder'
require 'checkout_sdk/checkout_static_keys_sdk_builder'
require 'checkout_sdk/checkout_sdk_builder'
require 'checkout_sdk/checkout_api'
require 'checkout_sdk/simple_logger'

# Configuration(Previous)
require 'checkout_sdk/previous/checkout_previous_static_keys_sdk_builder'
require 'checkout_sdk/previous/checkout_previous_sdk_builder'
require 'checkout_sdk/previous/previous_static_keys_sdk_credentials'
require 'checkout_sdk/previous/checkout_api'

# OAuth
require 'checkout_sdk/oauth_access_token'
require 'checkout_sdk/oauth_scopes'
require 'checkout_sdk/oauth_sdk_credentials'
require 'checkout_sdk/checkout_oauth_sdk_builder'

# Checkout modules
require 'checkout_sdk/common/common'
require 'checkout_sdk/customers/customers'
require 'checkout_sdk/disputes/disputes'
require 'checkout_sdk/forex/forex'
require 'checkout_sdk/instruments/instruments'
require 'checkout_sdk/payments/payments'
require 'checkout_sdk/reports/reports'
require 'checkout_sdk/sessions/sessions'
require 'checkout_sdk/tokens/tokens'
require 'checkout_sdk/apm/apm'
require 'checkout_sdk/accounts/accounts'
require 'checkout_sdk/workflows/workflows'
require 'checkout_sdk/risk/risk'
require 'checkout_sdk/balances/balances'
require 'checkout_sdk/transfers/transfers'
require 'checkout_sdk/metadata/metadata'
require 'checkout_sdk/financial/financial'
require 'checkout_sdk/issuing/issuing'

# Checkout modules (previous)
require 'checkout_sdk/sources/sources'
require 'checkout_sdk/reconciliation/reconciliation'
require 'checkout_sdk/webhooks/webhooks'
require 'checkout_sdk/events/events'

module CheckoutSdk
  include PlatformType

  # @return [CheckoutSdk::CheckoutSdkBuilder]
  def self.builder
    CheckoutSdkBuilder.new
  end
end
