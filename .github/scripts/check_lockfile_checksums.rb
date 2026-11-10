# frozen_string_literal: true

# Fails unless the lockfile only uses rubygems.org and the local gemspec, and every gem from
# rubygems.org has a sha256 in its CHECKSUMS section.
# Run by CI before bundle install. Standard library only.
# Usage: ruby .github/scripts/check_lockfile_checksums.rb Gemfile.lock

def fail_check(message)
  warn "check_lockfile_checksums: #{message}. Regenerate with .github/scripts/update-lockfiles.sh"
  exit 1
end

fail_check('usage: check_lockfile_checksums.rb <lockfile>') unless ARGV.size == 1
path = ARGV.first
fail_check("#{path} is not a regular file") unless File.file?(path) && !File.symlink?(path)

sections = Hash.new { |hash, key| hash[key] = [] }
current = nil
File.foreach(path, chomp: true) do |line|
  line = line.delete_suffix("\r")
  if line.match?(/\A[A-Z][A-Z ]*\z/)
    current = line
  elsif current
    sections[current] << line
  end
end

foreign = sections.keys & ['GIT', 'PLUGIN SOURCE', 'GEM SOURCE']
unless foreign.empty?
  fail_check("#{path} has #{foreign.join(' and ')} sources; only rubygems.org and the local gemspec are allowed")
end
remotes = (sections['GEM'] + sections['PATH']).filter_map { |line| line[/\A  remote: (.+)\z/, 1] }
fail_check("#{path} has unexpected remotes: #{remotes.inspect}") unless remotes.sort == ['.', 'https://rubygems.org/']

gems = sections['GEM'].filter_map { |line| line[/\A {4}(\S+ \([^)]+\))\z/, 1] }
fail_check("#{path} lists no gems") if gems.empty?
fail_check("#{path} has no CHECKSUMS section") unless sections.key?('CHECKSUMS')

checksums = sections['CHECKSUMS'].each_with_object({}) do |line, found|
  match = line.match(/\A {2}(\S+ \([^)]+\))(?: sha256=([0-9a-f]{64}))?\z/)
  found[match[1]] = match[2] if match
end

missing = gems.reject { |gem| checksums[gem] }
fail_check("no sha256 for #{missing.join(', ')}") unless missing.empty?

path_gems = sections['PATH'].filter_map { |line| line[/\A {4}(\S+ \([^)]+\))\z/, 1] }
unknown = checksums.keys - gems - path_gems
fail_check("CHECKSUMS names gems that are not locked: #{unknown.join(', ')}") unless unknown.empty?

puts "check_lockfile_checksums: #{gems.size} gems in #{path}, all with sha256"
