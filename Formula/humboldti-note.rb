class HumboldtiNote < Formula
  desc "A minimal daily markdown note-taking tool for your terminal."
  homepage "https://github.com/sphenisciformes-lab/humboldti"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.0/humboldti-note-aarch64-apple-darwin.tar.xz"
      sha256 "9971bd377b74e19e590f90c4ba883252dacc8350f41b63259524c7fcca12e6ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.0/humboldti-note-x86_64-apple-darwin.tar.xz"
      sha256 "2de16134f0f12a482ed98f85e4ee830a6088c78e8b1d1e07845602e71f7066b0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.0/humboldti-note-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bd0419205d4a53a1f7e6b55baa7de52cd92ee277cf44e32611c9630563f37584"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.0/humboldti-note-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ccae8b83f0dda8e600872c5ad25da4e77bdab1f1a910cda2a00b296a00de063f"
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
