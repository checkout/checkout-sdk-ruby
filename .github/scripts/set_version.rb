# frozen_string_literal: true

# Sets the gem version in lib/checkout_sdk/version.rb and in the checkout_sdk lines of the committed
# lockfiles, so a version bump needs neither Docker nor a dependency resolve. Dependency changes still
# need .github/scripts/update-lockfiles.sh. Standard library only; run from the repository root.
# Usage: ruby .github/scripts/set_version.rb <version>

VERSION_PATTERN = /\A\d+\.\d+\.\d+(\.(alpha|beta|rc|pre)\.?\d+)?\z/.freeze
VERSION_FILE = 'lib/checkout_sdk/version.rb'
# Lockfile => number of "checkout_sdk (X.Y.Z)" lines it holds (PATH specs, plus CHECKSUMS when present).
LOCKFILES = { 'Gemfile.lock' => 2, 'gemfiles/ruby_2_7.gemfile.lock' => 1 }.freeze

def fail_check(message)
  warn "set_version: #{message}"
  exit 1
end

# Replaces every match of pattern in path, after checking it matches exactly expected times.
def rewrite(path, pattern, expected)
  fail_check("#{path} is not a regular file") unless File.file?(path) && !File.symlink?(path)
  text = File.read(path)
  found = text.scan(pattern).size
  fail_check("expected #{expected} version line(s) in #{path}, found #{found}") unless found == expected
  File.write(path, yield(text))
end

fail_check('usage: set_version.rb <version>') unless ARGV.size == 1
version = ARGV.first
fail_check('the version is not a release or pre-release version') unless version.match?(VERSION_PATTERN)

version_line = /^  VERSION = '[^']*'$/
rewrite(VERSION_FILE, version_line, 1) { |text| text.sub(version_line, "  VERSION = '#{version}'") }

lock_line = /^( {2}| {4})checkout_sdk \([^)]+\)$/
LOCKFILES.each do |path, expected|
  rewrite(path, lock_line, expected) do |text|
    text.gsub(lock_line) { "#{Regexp.last_match(1)}checkout_sdk (#{version})" }
  end
end

puts "set_version: #{version} in #{VERSION_FILE} and #{LOCKFILES.keys.join(', ')}"
