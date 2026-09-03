class Plotui < Formula
  desc "Plot data from stdin or files as real terminal pixels (Kitty graphics): line, scatter, bar."
  homepage "https://plotui.xyz"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.5.0/plotui-aarch64-apple-darwin.tar.xz"
      sha256 "57fd32349619493cb55e58fc41a7b968e1d2918dd5827e210cced2e7f27adbca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.5.0/plotui-x86_64-apple-darwin.tar.xz"
      sha256 "26114a0a5ff848bd55bc76109fd7d326e8390eb22f8dd74cf89261e62a544c12"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.5.0/plotui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "efca4b79816aca4afaee8ee4ef74f06d4bc204e01eebe4321441acbef88d3d48"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.5.0/plotui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "86197085d114c051e6bc71906cbb3d2e25ef2ac2b6caea32c6b4fce5e07bcdb9"
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
