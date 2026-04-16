# Homebrew formula for Clove. Installs the self-contained macOS binary (no Bun).
# Docs: https://github.com/10ko/clove/blob/main/docs/homebrew.md

class Clove < Formula
  desc "Orchestrate coding agents (local or Docker) with CLI and dashboard"
  homepage "https://github.com/10ko/clove"
  url "https://github.com/10ko/clove/releases/download/v0.0.10/clove-macos-arm64.zip"
  version "0.0.10"
  sha256 "0073f601773d54ad57ed4405ac9864d477077043219df50f774fa1ccd4feaa3f"
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
