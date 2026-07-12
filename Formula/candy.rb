# Homebrew formula for candy (build-from-source — works on macOS + Linux).
#
# The published release binaries are Linux-only, so brew builds from source here
# (candy compiles on macOS too; the Linux-only VIP path is cfg-gated off). To use:
#
#   1. Copy this file into your tap as `Formula/candy.rb`
#      (e.g. the `astroville/homebrew-tap` repo), or:
#        brew tap astroville/tap
#        brew install candy
#   2. The repo is private, so brew needs auth to fetch the source tarball:
#        export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
#      (or make the repo/releases public).
#
# On each new tag: bump `url` + `version` and update `sha256` to the new source
# tarball's checksum:
#   curl -sL -H "Authorization: Bearer $(gh auth token)" \
#     https://github.com/astroville/candy/archive/refs/tags/<TAG>.tar.gz | shasum -a 256
class Candy < Formula
  desc "Single-binary distributed software load balancer"
  homepage "https://github.com/astroville/candy"
  url "https://github.com/astroville/candy/archive/refs/tags/v0.1.0-rc.2.tar.gz"
  version "0.1.0-rc.2"
  sha256 "58ff7c38595f1edef058777a4ec5f9736adfcdf6e03b89c85cb612fdf8399a14"
  # No open-source license yet (experimental / private use).
  head "https://github.com/astroville/candy.git", branch: "main"

  depends_on "rust" => :build

  def install
    # Installs the `candy` binary (crates/candy-cli) into the formula prefix.
    system "cargo", "install", "--locked", "--path", "crates/candy-cli", "--root", prefix
  end

  test do
    assert_match "candy", shell_output("#{bin}/candy --help")
  end
end
