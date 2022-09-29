# frozen_string_literal: true

module CheckoutSdk
  class SdkCredentials
    protected

    # @abstract
    def get_authorization(authorization_type)
      raise NotImplementedError, 'Implement this method in a child class'
    end
  end
end
