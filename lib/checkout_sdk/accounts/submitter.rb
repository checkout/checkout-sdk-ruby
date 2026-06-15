# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Captures evidence of the end-user's consent to onboarding.
    #
    # @!attribute ip_address
    #   @return [String] IP address of the end-user submitting the onboarding request.
    class Submitter
      attr_accessor :ip_address
    end
  end
end
