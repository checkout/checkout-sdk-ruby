# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # This object contains the Google SPA properties (non-hosted only).
    #
    # @!attribute continue_url
    #   @return [String] Fully qualified URL for redirecting the user's browser session after
    #     authentication. For example, this field may be the merchant's website for purchase
    #     confirmation once payment is complete. Required if in full redirect (not iframe) mode.
    class GoogleSpa
      attr_accessor :continue_url
    end
  end
end
