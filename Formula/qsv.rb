class Qsv < Formula
  desc "Ultra-fast CSV data-wrangling toolkit"
  homepage "https://qsv.dathere.com/"
  url "https://github.com/dathere/qsv/releases/download/29.0.0/qsv-29.0.0-aarch64-apple-darwin.zip"
  sha256 "63a4cfde04eff5168bba3765ebfdcf04c6b8b27002911ccd183f076bef67dd53"
  license any_of: ["MIT", "Unlicense"]

  # dathere publishes no x86_64-apple-darwin asset as of 22.0.1
  depends_on arch: :arm64
  depends_on :macos

  # The release archives ship no completions, so pull them from the tagged source.
  resource "completions-bash" do
    url "https://raw.githubusercontent.com/dathere/qsv/29.0.0/contrib/completions/examples/qsv.bash"
    sha256 "3f87e2a93c674c2d46d284c8088936e3f958ff461fbc53f7ddf8b7a1cf9852f8"

    livecheck do
      formula :parent
    end
  end

  resource "completions-zsh" do
    url "https://raw.githubusercontent.com/dathere/qsv/29.0.0/contrib/completions/examples/qsv.zsh"
    sha256 "436fe2db843eacf228fced8fa118bf88cbe53978034116b15621fb84059c80ef"

    livecheck do
      formula :parent
    end
  end

  resource "completions-fish" do
    url "https://raw.githubusercontent.com/dathere/qsv/29.0.0/contrib/completions/examples/qsv.fish"
    sha256 "3280baebee224baa60fbbd45795604c133704a5cc5569bc3b20d78ca5f1c17d4"

    livecheck do
      formula :parent
    end
  end

  def install
    %w[qsv qsvlite].each do |name|
      next unless File.exist?(name)

      libexec.install name
      (bin/name).write_env_script libexec/name, QSV_NO_UPDATE: "1"
    end
    doc.install Dir["README*", "THIRD_PARTY_NOTICES.md"]

    resource("completions-bash").stage { bash_completion.install "qsv.bash" => "qsv" }
    resource("completions-zsh").stage { zsh_completion.install "qsv.zsh" => "_qsv" }
    resource("completions-fish").stage { fish_completion.install "qsv.fish" }
  end

  def caveats
    <<~EOS
      These are dathere's official prebuilt binaries, so unlike homebrew-core's
      qsv they include the Polars commands (sqlp, joinp, pivotp) and viz.

      They are built with the self_update feature, so the qsv in bin is a
      wrapper that sets QSV_NO_UPDATE=1 to stop qsv replacing the binary
      Homebrew manages.
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
