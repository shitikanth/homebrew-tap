cask "xh" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "apple-darwin", linux: "unknown-linux-musl"

  version "0.26.3"
  sha256 arm:          "50d61bd755942752b054297a1612ec191654f137f8939673cda83c686cb5b0f2",
         intel:        "b1c07e42238485bdcbed0982766f58b4daa631f0a33870100054ef5fbb4a3c4b",
         arm64_linux:  "a45d8cb6c234c6850f9fc2395fc3544ab7691fb511237f00179aedba1bcd525e",
         x86_64_linux: "cbbf53bd76007d57d95e4bed8ba7fb3b7fcec22af4bdfc1ff119cd5de351e74f"

  url "https://github.com/ducaale/xh/releases/download/v#{version}/xh-v#{version}-#{arch}-#{os}.tar.gz"
  name "xh"
  desc "Friendly and fast tool for sending HTTP requests"
  homepage "https://github.com/ducaale/xh"

  binary "xh-v#{version}-#{arch}-#{os}/xh"
  manpage "xh-v#{version}-#{arch}-#{os}/doc/xh.1"
  bash_completion "xh-v#{version}-#{arch}-#{os}/completions/xh.bash"
  zsh_completion "xh-v#{version}-#{arch}-#{os}/completions/_xh"
  fish_completion "xh-v#{version}-#{arch}-#{os}/completions/xh.fish"
end
