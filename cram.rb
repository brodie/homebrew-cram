class Cram < Formula
  desc "Functional tests for command-line applications"
  homepage "https://bitheap.org/cram/"
  url "https://bitheap.org/cram/cram-0.7.tar.gz"
  sha256 "7da7445af2ce15b90aad5ec4792f857cef5786d71f14377e9eb994d8b8337f2f"

  head "https://github.com/brodie/cram.git"

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    assert_match "Cram CLI testing framework",
                 shell_output("#{bin}/cram --version")

    path = testpath/"hello.t"
    path.write <<-EOS.undent
      Hello:

        $ echo hello
        hello
    EOS

    system "#{bin}/cram", path
  end
end
