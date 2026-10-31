class Pitwall < Formula
  desc "F1 live timing in your terminal"
  homepage "https://github.com/jmvezic/pitwall-tui"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.1/pitwall-tui-aarch64-apple-darwin.tar.xz"
      sha256 "9193633e484bd2b570d9b9f74de0797870bf703f012fa04778fd87ba4fcc4339"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.1/pitwall-tui-x86_64-apple-darwin.tar.xz"
      sha256 "a3d98db18981bc160c023e27519d2c5910f37a1eef55d77a473d180df4e65527"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.1/pitwall-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d5f45dbed1b8a88a5f074bf5e4f86d66b361790825d8a8166f1b5426b5c9e1d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.1/pitwall-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0f246c27620c8eefe7edd49659fabe90404f5e5665f48c178de379b7e99deb5b"
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
