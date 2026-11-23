class ArcCli < Formula
  desc "arc: local agent for coordinating coding agents and sharing team memory"
  homepage "https://getarc.dev"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.7/arc-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1c50b79d8514e6d196b9f224708127dd1d3146d61d0edc7e2b76d335a321feb4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.7/arc-cli-x86_64-apple-darwin.tar.xz"
      sha256 "769b31355fdd501ce4d227c6861970d4f1f183330bb3268a7a3d6e66f07c1c2a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.7/arc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1eab398a3ff449a83c4ad553ff13a6e333cfe8944c6e4379a461a0772e977b61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.7/arc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c7694c4adde71f6ef7476768e6ce655d6c06d976ca3d016072c576d70b24a8dd"
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
