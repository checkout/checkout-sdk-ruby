# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module AmlScreening
      # The screening configuration to use for an AML verification.
      #
      # @!attribute configuration_identifier
      #   @return [String] Your AML Screening configuration ID.
      class AmlSearchParameters
        attr_accessor :configuration_identifier
      end
    end
  end
end
