# Homebrew formula for Clove. Installs the self-contained macOS binary (no Bun).
# Docs: https://github.com/10ko/clove/blob/main/docs/homebrew.md

class Clove < Formula
  desc "Orchestrate coding agents (local or Docker) with CLI and dashboard"
  homepage "https://github.com/10ko/clove"
  url "https://github.com/10ko/clove/releases/download/v0.0.13/clove-macos-arm64.zip"
  version "0.0.13"
  sha256 "d2c546db5f4c24299ddfb924dbbed592695169e646ed034200360599589912fb"
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
