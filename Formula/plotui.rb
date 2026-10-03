class Plotui < Formula
  desc "Plot data from stdin or files as real terminal pixels (Kitty graphics): line, scatter, bar."
  homepage "https://plotui.xyz"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.6.0/plotui-aarch64-apple-darwin.tar.xz"
      sha256 "e572992cf4dbc2a4c9c95002c6c9482eb3f38a961387bf64e75898e376edd086"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.6.0/plotui-x86_64-apple-darwin.tar.xz"
      sha256 "e6f5c1415e6f48080b2d25dc269c405ee2193c821c7eba0b6a7e48732da4a310"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.6.0/plotui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d7951416993d719c89dc801908724852d4f16c7083584622dbc78fc1cee42136"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.6.0/plotui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2b7b0e11e531faf23b14efe8896f6cb000456dcfeb4af3d98a067f7182f6f4ba"
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
