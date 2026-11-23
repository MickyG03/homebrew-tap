class ArcCli < Formula
  desc "arc: local agent for coordinating coding agents and sharing team memory"
  homepage "https://getarc.dev"
  version "0.2.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.10/arc-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7e0b375d96ccc8c874d21e34e03d32dd908e75e57748f65b6329b02ed8a76ee8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.10/arc-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2bd5bb74519457f5fcf54c3b28532cf5c7fbb4fa343b7f9023606e2a06d3f756"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.10/arc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "424cfdaf2a3790692b358f23740f7e2ec09a7c4b110dee3865fa9ce77c444f00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.10/arc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1f746b931a07ba1c1ca6480959a50639010ccf5f1f6a9a0da7258ee10f3219ec"
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
