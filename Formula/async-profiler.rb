class AsyncProfiler < Formula
  desc "Low overhead sampling profiler for Java"
  homepage "https://github.com/async-profiler/async-profiler"
  url "https://github.com/async-profiler/async-profiler/releases/download/v3.0/async-profiler-3.0-macos.zip"
  sha256 "cae4f207c33b964276385272a7cfe3750594cbcc8918f97a4bb67292bdbc43a8"
  license "Apache-2.0"

  on_linux do
    on_intel do
      url "https://github.com/async-profiler/async-profiler/releases/download/v3.0/async-profiler-3.0-linux-x64.tar.gz"
      sha256 "2b631e8c0418e7e8a19d59a2d2eff016e87f8a4ffbac1ea395ec750b39dc3ce8"
    end
    on_arm do
      url "https://github.com/async-profiler/async-profiler/releases/download/v3.0/async-profiler-3.0-linux-arm64.tar.gz"
      sha256 "8d3b407055f66756eb9525a814cbcf119951a8fb82055df9471b6559326f7607"
    end
  end

  def install
    bin.install "bin/asprof"
  end

  test do
    system "#{bin}/asprof", "--version"
  end
end
