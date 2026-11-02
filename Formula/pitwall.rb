class Pitwall < Formula
  desc "F1 live timing in your terminal"
  homepage "https://github.com/jmvezic/pitwall-tui"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.4/pitwall-tui-aarch64-apple-darwin.tar.xz"
      sha256 "aa0269c43c58174023eaa67c226993aa3f129da01d1ab85ff0a18afc56c45e8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.4/pitwall-tui-x86_64-apple-darwin.tar.xz"
      sha256 "4ac075a16173d48a00caf5b8560f05caaaae0a76ccc2db6d37f153245b43544e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.4/pitwall-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bd4f92f7d6c87cc02ebb3bb20d1156ca38ea79d6ed1b1018efa23b5120c7f794"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.4/pitwall-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "562c9537724bf0b36074daae79dfadedf6be59d43340ad424821f2f51bd4f400"
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
