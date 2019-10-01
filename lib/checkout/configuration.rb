module Checkout
  class Configuration
    attr_accessor :secret_key, :public_key, :base_url

    def initialize
      @secret_key = nil
      @public_key = nil
      @base_url = nil
    end
  end
end
