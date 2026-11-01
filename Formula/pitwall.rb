class Pitwall < Formula
  desc "F1 live timing in your terminal"
  homepage "https://github.com/jmvezic/pitwall-tui"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.3/pitwall-tui-aarch64-apple-darwin.tar.xz"
      sha256 "f693eb0de5714b1f6e56741fcf0cb78047ec1b29512ac2c0ce684ada281abee2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.3/pitwall-tui-x86_64-apple-darwin.tar.xz"
      sha256 "18f8c977029d637ea590f510a135fc59b9c209622618f21fab8dc257fea3829f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.3/pitwall-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "80f9afd789fa38abe8d6db33a12a7110cd44100753546324c3ffc72d348957e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmvezic/pitwall-tui/releases/download/v0.1.3/pitwall-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d2de98a02b53a49536e751863f74f50b7f6918a5f5244650d962e84eea8a876f"
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
