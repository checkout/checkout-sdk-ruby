lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "checkout_sdk/version"

Gem::Specification.new do |spec|
  spec.name          = "checkout_sdk"
  spec.version       = CheckoutSdk::VERSION
  spec.authors       = ["Khalid Jazaerly"]
  spec.email         = ["khalid.jaz@gmail.com"]

  spec.summary       = %q{A Ruby API wrapper for checkout.com.}
  spec.description   = %q{A Ruby API wrapper for checkout.com.}
  spec.homepage      = "http://checkout.com"
  spec.require_paths = ["lib"]
  spec.license       = "MIT"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "excon"
end
