class HumboldtiNote < Formula
  desc "A minimal daily markdown note-taking tool for your terminal."
  homepage "https://github.com/sphenisciformes-lab/humboldti"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.1/humboldti-note-aarch64-apple-darwin.tar.xz"
      sha256 "2bca223f3c97895d900d35e58e0fed15478e192c465261403fde106ac7edb673"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.1/humboldti-note-x86_64-apple-darwin.tar.xz"
      sha256 "dfc07f89545fd4212e7faba7121ffb72560f6fa04a53e373d1053f0acf668fb7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.1/humboldti-note-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "02b3ce7d66dc2467e50d0f20b08b1a6645bded765a2c4ddfa4a642e8e592c27c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.1/humboldti-note-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "39118409f3449bfab862c3cc3f835f0649bcdf484aaa263ef299713644486021"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
      bin.install "pen"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pen"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pen"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pen"
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
