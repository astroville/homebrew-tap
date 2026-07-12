# Homebrew formula for star-dns.
#
# The astroville/star-dns source repo is PRIVATE, but its prebuilt release
# binaries are published to the PUBLIC astroville/star-dns-releases repo, so
# brew downloads them with no GitHub token. Install:
#
#   brew tap astroville/tap
#   brew install star-dns
#
# On each new release, bump `version` and replace every `sha256` with the value
# from the matching line of the release's checksums file:
#   curl -sL https://github.com/astroville/star-dns-releases/releases/download/vX.Y.Z/star-dns_X.Y.Z_checksums.txt
class StarDns < Formula
  desc "Lightweight clustered DNS server for local engineering environments"
  homepage "https://github.com/astroville/star-dns"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/astroville/star-dns-releases/releases/download/v0.1.3/star-dns_0.1.3_darwin_arm64.tar.gz"
      sha256 "97b607b7bb4fbaa5f1caed67c3da75f53fde22c1719737a30cc40e633aa23fd1"
    else
      url "https://github.com/astroville/star-dns-releases/releases/download/v0.1.3/star-dns_0.1.3_darwin_amd64.tar.gz"
      sha256 "f579df24674f68e2dcaef81d3cff03c1c4ef10363452cdab4f8ca739206eede2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/astroville/star-dns-releases/releases/download/v0.1.3/star-dns_0.1.3_linux_arm64.tar.gz"
      sha256 "55b35c45727858a4c0aa62f1ba31f7e5a1f3cf7d7736d2f7c30efe9748c3fac6"
    else
      url "https://github.com/astroville/star-dns-releases/releases/download/v0.1.3/star-dns_0.1.3_linux_amd64.tar.gz"
      sha256 "bd08c69665733d3edfc3f26f3d69c9b82fca16ba860aefb6e8063bc8ac2ea49e"
    end
  end

  def install
    bin.install "star-dns"
    # (etc/"star-dns").install creates the target dir; a bare etc.install rename
    # into a non-existent subdir fails with ENOENT.
    (etc/"star-dns").install "config.yaml" unless (etc/"star-dns/config.yaml").exist?
  end

  def caveats
    <<~EOS
      Star DNS was installed.

      Quick start:
        star-dns

      Config file:
        #{etc}/star-dns/config.yaml

      Run as a service:
        brew services start star-dns
    EOS
  end

  service do
    run [opt_bin/"star-dns", "-config", etc/"star-dns/config.yaml"]
    keep_alive true
    log_path var/"log/star-dns.log"
    error_log_path var/"log/star-dns.log"
  end

  test do
    system "#{bin}/star-dns", "-h"
  end
end
