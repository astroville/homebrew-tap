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
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/astroville/star-dns-releases/releases/download/v0.1.2/star-dns_0.1.2_darwin_arm64.tar.gz"
      sha256 "eafeb81b06aa3952d1efdd3313fd72df0316ae82137fb81ff5021ab761f3956c"
    else
      url "https://github.com/astroville/star-dns-releases/releases/download/v0.1.2/star-dns_0.1.2_darwin_amd64.tar.gz"
      sha256 "e3549cc223c4016f53e54a717a1df90d23d06d492017d265a7072ac5bb863151"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/astroville/star-dns-releases/releases/download/v0.1.2/star-dns_0.1.2_linux_arm64.tar.gz"
      sha256 "78e6c7a433def466c199b96633d547b546f89f8bd5f491b4e2e829d096d7e288"
    else
      url "https://github.com/astroville/star-dns-releases/releases/download/v0.1.2/star-dns_0.1.2_linux_amd64.tar.gz"
      sha256 "be417690adbf41ca91e242d890b2a748a1d06bdff279e827d4038c2953262c82"
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
