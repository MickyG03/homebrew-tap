class ArcCli < Formula
  desc "arc: local agent for coordinating coding agents and sharing team memory"
  homepage "https://getarc.dev"
  version "0.2.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.11/arc-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f333b962a1db441ab4da68f5643d50d5e656b339666289b3eb464ba1870c9ae9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.11/arc-cli-x86_64-apple-darwin.tar.xz"
      sha256 "5222ce3d4b8a8da8be19f280b45038d01423192f81899d345b6f4a5514980047"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.11/arc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c8ceb523091ffa9a9602b1d5926e9660a08e0959f4a9b5f0d842cb34b08e7acf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.11/arc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ec7923255ddd8085e800b60af84a17cf8178d67ed2c14635ee1d297da4bda57f"
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
