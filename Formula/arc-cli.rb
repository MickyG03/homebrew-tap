class ArcCli < Formula
  desc "arc: local agent for coordinating coding agents and sharing team memory"
  homepage "https://getarc.dev"
  version "0.2.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.15/arc-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4e97e009e5972d7b64efcba2097dc8476d1396529bb7d1d01020009513d4ca34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.15/arc-cli-x86_64-apple-darwin.tar.xz"
      sha256 "359843cd89abac60de947a913fbcd7e1ffcbeb8df447b1e45395b5a38aaecbe4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.15/arc-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "affdfd9d7af5ed099c70589628b155a58cad3842fda6478b5a1257e0abd6ba4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/MickyG03/arc-releases/releases/download/v0.2.15/arc-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4bdbe48e679f61fc22bfc50538eed9d59c2c5f683f247cb77234b3cd1b66866e"
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
