# frozen_string_literal: true

# Checks the gem built by the release workflow before it is uploaded for publishing.
# Standard library only. Usage: ruby .github/scripts/verify_gem.rb <version>
#
# Fails unless the working directory holds exactly checkout_sdk-<version>.gem, and that gem:
#   - is named checkout_sdk and carries <version>;
#   - has no native extensions and no executables (nothing runs when merchants install it);
#   - packages only regular files (no symlinks or links), only under lib/, sig/ and the known
#     top-level files (no lockfiles, CI files or specs).

require 'rubygems/package'
require 'zlib'

VERSION_PATTERN = /\A\d+\.\d+\.\d+(\.(alpha|beta|rc|pre)\.?\d+)?\z/.freeze
ALLOWED_TOP_LEVEL = %w[
  .overcommit.yml .rspec .rubocop.yml .ruby-version CODE_OF_CONDUCT.md Gemfile LICENSE.md README.md Rakefile
].freeze
ALLOWED_DIRECTORIES = %r{\A(?:lib|sig)/}.freeze

# Names of the entries in the gem's data archive that are not regular files.
def non_regular_entries(gem_path)
  found = []
  File.open(gem_path, 'rb') do |io|
    Gem::Package::TarReader.new(io).each do |outer|
      next unless outer.full_name == 'data.tar.gz'

      Zlib::GzipReader.wrap(outer) do |gzip|
        Gem::Package::TarReader.new(gzip).each { |entry| found << entry.full_name unless entry.file? }
      end
    end
  end
  found
end

def fail_check(message)
  warn "verify_gem: #{message}"
  exit 1
end

fail_check('usage: verify_gem.rb <version>') unless ARGV.size == 1
version = ARGV.first
fail_check('the version is not a release or pre-release version') unless version.match?(VERSION_PATTERN)

expected = "checkout_sdk-#{version}.gem"
built = Dir.children(Dir.pwd).select { |name| name.end_with?('.gem') }
fail_check("expected only #{expected}, found #{built.sort.inspect}") unless built == [expected]

package = Gem::Package.new(expected)
spec = package.spec
fail_check("gem name is #{spec.name}") unless spec.name == 'checkout_sdk'
fail_check("gem version is #{spec.version}") unless spec.version.to_s == version
fail_check('the gem declares native extensions') unless spec.extensions.empty?
fail_check('the gem declares executables') unless spec.executables.empty?

contents = package.contents
fail_check('the gem file list does not match its contents') unless contents.sort == spec.files.sort
fail_check('lib/checkout_sdk/version.rb is missing') unless contents.include?('lib/checkout_sdk/version.rb')

links = non_regular_entries(expected)
fail_check("entries that are not regular files: #{links.sort.inspect}") unless links.empty?

unsafe = contents.select { |path| path.start_with?('/') || path.split('/').include?('..') }
fail_check("unsafe paths in the gem: #{unsafe.sort.inspect}") unless unsafe.empty?

unexpected = contents.reject { |path| ALLOWED_DIRECTORIES.match?(path) || ALLOWED_TOP_LEVEL.include?(path) }
fail_check("unexpected files in the gem: #{unexpected.sort.inspect}") unless unexpected.empty?

puts "verify_gem: #{expected} OK (#{contents.size} files)"
