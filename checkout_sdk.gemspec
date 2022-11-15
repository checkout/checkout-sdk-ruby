# frozen_string_literal: true

require_relative 'lib/checkout_sdk/version'

Gem::Specification.new do |spec|
  spec.name = 'checkout_sdk'
  spec.version = CheckoutSdk::VERSION
  spec.authors = ['Checkout']
  spec.email = ['integration@checkout.com']

  spec.summary = 'Ruby wrapper for Checkout API'
  spec.description = "Accept online payments, create a Platform, and pay out to your sub-entities,
sellers and service providers."
  spec.homepage = 'https://www.checkout.com/'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/checkout/checkout-sdk-ruby'
  spec.metadata['documentation_uri'] = 'https://www.checkout.com/docs'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_development_dependency 'rake', '>= 13.0'
  spec.add_development_dependency 'rspec', '>= 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.36.0'
  spec.add_dependency 'faraday', '>= 2.0.0'
  spec.add_dependency 'faraday-multipart', '~> 1.0.4'
  spec.add_dependency 'mime-types', '~> 3.0'
end
