class Plotui < Formula
  desc "Plot data from stdin or files as real terminal pixels (Kitty graphics): line, scatter, bar."
  homepage "https://plotui.xyz"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.5.1/plotui-aarch64-apple-darwin.tar.xz"
      sha256 "d424e2b1fb053fb3f519560cabc34136d07e773d6333b06edf4b5966da0a3fcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.5.1/plotui-x86_64-apple-darwin.tar.xz"
      sha256 "ecea60eb7d246ae4588537fd357716e9558b7724381f88d2ee2aebb56844208a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.5.1/plotui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fa2eb3a5eab927899cd31ee4e1dde48cdb933031f202e32c83383c70498ed9c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.5.1/plotui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "756afe3a22dc96fa0c21a0ded36c86d6111748acca995bccf23bfc4f5eca7380"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "plotui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "plotui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "plotui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "plotui"
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
