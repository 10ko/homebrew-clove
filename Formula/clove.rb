# Homebrew formula for Clove. No code signing needed — installs from source and runs with Bun.
# Tap: brew tap 10ko/clove && brew install clove
# Docs: https://github.com/10ko/clove/blob/main/docs/homebrew.md

class Clove < Formula
  desc "Orchestrate coding agents (local or Docker) with CLI and dashboard"
  homepage "https://github.com/10ko/clove"
  url "https://github.com/10ko/clove/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"
  depends_on "oven-sh/bun/bun"

  def install
    libexec.install Dir["*"]
    cd libexec do
      system Formula["bun"].opt_bin/"bun", "install"
      system Formula["bun"].opt_bin/"bun", "run", "build"
      system Formula["bun"].opt_bin/"bun", "run", "dashboard:build"
    end

    (bin/"clove").write <<~EOS
      #!/bin/bash
      cd "#{libexec}" && exec "#{Formula["bun"].opt_bin}/bun" run bin/clove.js "$@"
    EOS
    chmod 0555, bin/"clove"
  end

  test do
    assert_match "clove – orchestrate", shell_output("#{bin}/clove --help")
  end
end
