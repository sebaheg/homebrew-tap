class Plotui < Formula
  desc "Plot data from stdin or files as real terminal pixels (Kitty graphics): line, scatter, bar."
  homepage "https://plotui.xyz"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.4.2/plotui-aarch64-apple-darwin.tar.xz"
      sha256 "814379283bdad50276e33c321a9536f90ddb7bfbce805df24f914015175565eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.4.2/plotui-x86_64-apple-darwin.tar.xz"
      sha256 "e805b3fc9b8b584e273404f3f34a09a74c9b778989dda9dedc4ba2970c55ae96"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sebaheg/plotui/releases/download/v0.4.2/plotui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "de94ba3ab25f6584424756eef41aaf8bce8e3343fcb4808110ced4342b1db1d4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sebaheg/plotui/releases/download/v0.4.2/plotui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6f8214d56a7519af70963ba07141208eb348427bb657a309fbad79e934a4849"
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
