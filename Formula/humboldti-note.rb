class HumboldtiNote < Formula
  desc "A minimal daily markdown note-taking tool for your terminal."
  homepage "https://github.com/sphenisciformes-lab/humboldti"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.2/humboldti-note-aarch64-apple-darwin.tar.xz"
      sha256 "5eb8ca431ea89c12d25c1cd99e21d6c03601a2b7cb12740a66edf0d3f63e360c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.2/humboldti-note-x86_64-apple-darwin.tar.xz"
      sha256 "5a706118823caf026d303a81a7dfb397decfb53f87c8f6db31e387f5e7fa7c3c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.2/humboldti-note-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6797d9912fa10563a8e3e1b63913d83095300a273788b86f56a853c76927d95e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sphenisciformes-lab/humboldti/releases/download/v0.1.2/humboldti-note-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1de4f8100cc1981df40bba90aaf3c99fbd8810ecfdcefc3604333cf2a7e3420d"
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
