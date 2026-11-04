class Qsv < Formula
  desc "Ultra-fast CSV data-wrangling toolkit"
  homepage "https://qsv.dathere.com/"
  url "https://github.com/dathere/qsv/releases/download/22.0.1/qsv-22.0.1-aarch64-apple-darwin.zip"
  sha256 "735f366fb6272a772653c7106e42fd8b069a86d96eb0f9dbaf38945de09793ea"
  license any_of: ["MIT", "Unlicense"]

  # dathere publishes no x86_64-apple-darwin asset as of 22.0.1
  depends_on arch: :arm64
  depends_on :macos

  # The release archives ship no completions, so pull them from the tagged source.
  resource "completions-bash" do
    url "https://raw.githubusercontent.com/dathere/qsv/22.0.1/contrib/completions/examples/qsv.bash"
    sha256 "0ff0ee2cc80a6e4d1abe51d2f4fb7a4eb2f9c2c774ec482f89a218d7dda432e1"
  end

  resource "completions-zsh" do
    url "https://raw.githubusercontent.com/dathere/qsv/22.0.1/contrib/completions/examples/qsv.zsh"
    sha256 "96da774fb3310a684028a966a606cd9f29203686f5700dd10adecfedeae0e132"
  end

  resource "completions-fish" do
    url "https://raw.githubusercontent.com/dathere/qsv/22.0.1/contrib/completions/examples/qsv.fish"
    sha256 "13af39213d58d7e819ed22c3e7dde27b4201b2635565bc7f5c1d15048a142f2e"
  end

  def install
    bin.install "qsv"
    bin.install "qsvlite" if File.exist?("qsvlite")
    doc.install Dir["README*", "THIRD_PARTY_NOTICES.md"]

    resource("completions-bash").stage { bash_completion.install "qsv.bash" => "qsv" }
    resource("completions-zsh").stage { zsh_completion.install "qsv.zsh" => "_qsv" }
    resource("completions-fish").stage { fish_completion.install "qsv.fish" }
  end

  def caveats
    <<~EOS
      These are dathere's official prebuilt binaries, so unlike homebrew-core's
      qsv they include the Polars commands (sqlp, joinp, pivotp) and viz.

      They are also built with the self_update feature. Set QSV_NO_UPDATE=1 to
      stop qsv replacing the binary Homebrew manages:
        export QSV_NO_UPDATE=1
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qsv --version")

    (testpath/"t.csv").write("a,b\n1,2\n3,4\n")
    assert_equal "sa,sb\n4,6\n",
                 shell_output("#{bin}/qsv sqlp #{testpath}/t.csv " \
                              "'select sum(a) as sa, sum(b) as sb from _t_1'")
  end
end
