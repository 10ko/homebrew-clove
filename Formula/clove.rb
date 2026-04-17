# Homebrew formula for Clove. Installs the self-contained macOS binary (no Bun).
# Docs: https://github.com/10ko/clove/blob/main/docs/homebrew.md

class Clove < Formula
  desc "Orchestrate coding agents (local or Docker) with CLI and dashboard"
  homepage "https://github.com/10ko/clove"
  url "https://github.com/10ko/clove/releases/download/v0.0.12/clove-macos-arm64.zip"
  version "0.0.12"
  sha256 "9eb2b6ce0a0bf1267a5c4ec10c0f7e654dfeb9f89173abec21d4dbdcb684a9bf"
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
