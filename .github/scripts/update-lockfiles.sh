#!/usr/bin/env bash
# Regenerates the committed lockfiles in linux/amd64 containers, so they resolve for the CI
# runners and not for the local machine. Needs Docker.
#
#   Gemfile.lock                    Ruby 3.1, Bundler 2.6.9, with gem checksums.
#                                   Ruby 3.1 and 3.3 CI legs and the release workflow.
#   gemfiles/ruby_2_7.gemfile.lock  Ruby 2.7, Bundler 2.4.22 (the last Bundler for Ruby 2.7,
#                                   which cannot record checksums). Ruby 2.7 CI leg only.
#
# CI installs with frozen lockfiles and fails when they are missing or out of date, so run this
# after changing the Gemfile, the gemspec or lib/checkout_sdk/version.rb (the lock records the
# gem's own version). Without arguments it keeps every locked version that still satisfies the
# Gemfile; `--update` re-resolves all gems to the newest allowed versions.
#
# Usage: .github/scripts/update-lockfiles.sh [--update]
set -euo pipefail

cd "$(dirname "$0")/../.."

update=''
case "${1:-}" in
  '') ;;
  --update) update='--update' ;;
  *) echo "usage: $0 [--update]" >&2; exit 2 ;;
esac

lock() {
  local ruby_version="$1"
  local bundler_version="$2"
  local gemfile="$3"
  local extra_lock_args="$4"
  docker run --rm --platform linux/amd64 \
    -v "$PWD:/src" -w /src \
    -e BUNDLE_GEMFILE="$gemfile" -e UPDATE="$update" -e BUNDLER_VERSION="$bundler_version" -e EXTRA="$extra_lock_args" \
    "ruby:${ruby_version}" bash -euc '
      git config --global --add safe.directory /src
      gem install bundler -v "$BUNDLER_VERSION" --no-document --silent
      # shellcheck disable=SC2086
      bundle "_${BUNDLER_VERSION}_" lock $UPDATE --add-platform ruby x86_64-linux $EXTRA
    '
}

lock 3.1 2.6.9 Gemfile --add-checksums
lock 2.7 2.4.22 gemfiles/ruby_2_7.gemfile ''

echo 'Lockfiles updated. Review the diff before committing.'
