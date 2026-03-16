# Homebrew formula for Clove. Installs the self-contained macOS binary (no Bun).
# Docs: https://github.com/10ko/clove/blob/main/docs/homebrew.md

class Clove < Formula
  desc "Orchestrate coding agents (local or Docker) with CLI and dashboard"
  homepage "https://github.com/10ko/clove"
  url "https://github.com/10ko/clove/releases/download/v0.0.2/clove-macos-arm64.zip"
  # Filled by update-homebrew-tap workflow when you upload clove-macos-arm64.zip to the release
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  def install
    libexec.install "clove-macos-arm64", "dashboard"
    chmod 0555, libexec/"clove-macos-arm64"
    (bin/"clove").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/clove-macos-arm64" "$@"
    EOS
    chmod 0555, bin/"clove"
  end

  test do
    assert_match "clove – orchestrate", shell_output("#{bin}/clove --help")
  end
end
