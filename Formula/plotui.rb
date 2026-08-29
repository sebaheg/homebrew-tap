class Plotui < Formula
  desc "Plot data from stdin or files as real terminal pixels (Kitty graphics): line, scatter, bar."
  homepage "https://plotui.xyz"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.4.1/plotui-aarch64-apple-darwin.tar.xz"
      sha256 "249e4c3d8bd992d476200f130543ec05d80769e1c8aec6ebf42ba73e06787d0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.4.1/plotui-x86_64-apple-darwin.tar.xz"
      sha256 "371c735e6a597e8230268e76882d05123190d6196bd76c6f22b3f99f0816c29b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.4.1/plotui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cc50b7d2932e579fc2ad368e29a9a517c011c18a628835691cc57cf967b2d7bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.4.1/plotui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d3e6041ff3325c6aa5068c1dd121968967decd521ae54bcfe8ee25c71762a3cb"
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
