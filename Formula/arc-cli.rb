class ArcCli < Formula
  desc "arc: local agent for coordinating coding agents and sharing team memory"
  homepage "https://getarc.dev"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.6/arc-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c0e2054e58dfa973744fbcaa00fb7dcbe2110057f63ffcf4b1f49163800a54a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.6/arc-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ecdf7e04c0f2b7804586d3e387a233591bd7468c2ef0a2ed33abb73ef33c25c8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.6/arc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d43efa68491498bdcccb0727babec74f42e983c62fc52ad97be7e55e76551095"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.6/arc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aa0e4590b669014703fc85469dcc0ae2521ead82e4dcb07e867424c81ee2aa11"
    end
  end
  license "UNLICENSED"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "arc"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "arc"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "arc"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "arc"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
