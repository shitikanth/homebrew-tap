class AsyncProfiler < Formula
  desc "Low overhead sampling profiler for Java"
  homepage "https://github.com/async-profiler/async-profiler"
  url "https://github.com/async-profiler/async-profiler/releases/download/v3.0/async-profiler-3.0-macos.zip"
  sha256 "cae4f207c33b964276385272a7cfe3750594cbcc8918f97a4bb67292bdbc43a8"
  license "Apache-2.0"

  def install
    bin.install "bin/asprof"
    lib.install Dir["lib/*"]
  end

  test do
    system "#{bin}/asprof", "--version"
  end
end
