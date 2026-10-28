class Pitwall < Formula
  desc "F1 live timing in your terminal"
  homepage "https://github.com/jmvezic/pitwall-tui"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.0/pitwall-tui-aarch64-apple-darwin.tar.xz"
      sha256 "7b2834b3bd2649256b4f12fe170847992328da73aacb42afd80ae882f8c16c4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.0/pitwall-tui-x86_64-apple-darwin.tar.xz"
      sha256 "984fa5e38c00be41ebdf77845b3cbf08fa27f17015bb082c6a2ff5790ea1b25f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.0/pitwall-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "52232a843be1c1f116e481877ad403c1070eb5d4f28aab4142dcb4378f3c250a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.0/pitwall-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "75d951f6cd70661f1b2575f3669e1062120c93c76dcc84a85113290ebe9bc21c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "pitwall"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pitwall"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pitwall"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pitwall"
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
