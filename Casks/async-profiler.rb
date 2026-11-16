cask "async-profiler" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux-#{arch}"
  ext = on_system_conditional macos: "zip", linux: "tar.gz"

  version "4.6"
  sha256 arm:          "646540c3c852d7fa7e43bbc4f090a193b7bfaf62d0954b42e98eae09edf36113",
         intel:        "646540c3c852d7fa7e43bbc4f090a193b7bfaf62d0954b42e98eae09edf36113",
         arm64_linux:  "e9e26d2aae0d2935a0a676342c2e4612076ef15f04788c82f965d408a6659fbb",
         x86_64_linux: "1e79ed54d8952889a2e74f993d22ee925e3322460d4f37a2ed95bfb88585da36"

  url "https://github.com/async-profiler/async-profiler/releases/download/v#{version}/async-profiler-#{version}-#{os}.#{ext}"
  name "async-profiler"
  desc "Low overhead sampling profiler for Java"
  homepage "https://github.com/async-profiler/async-profiler"

  binary "async-profiler-#{version}-#{os}/bin/asprof"
end
