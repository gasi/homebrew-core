class Whalebrew < Formula
  desc "Homebrew, but with Docker images"
  homepage "https://github.com/whalebrew/whalebrew"
  url "https://github.com/whalebrew/whalebrew.git",
      tag:      "0.4.0",
      revision: "bdf94887abf0397341c1d241974eea790626ae7c"
  license "Apache-2.0"
  head "https://github.com/whalebrew/whalebrew.git", branch: "master"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1997f2e5780dcbae7fd1002e6ca31cf3bfe66e0dcf09e4bcecc300ee4685ad99"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "45675eb4fb83c79dcfa2df9943824504e940c8804f707839f57fe5db0524e732"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "45675eb4fb83c79dcfa2df9943824504e940c8804f707839f57fe5db0524e732"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "45675eb4fb83c79dcfa2df9943824504e940c8804f707839f57fe5db0524e732"
    sha256 cellar: :any_skip_relocation, sonoma:         "b9e5094e28030f5f92e4100ee53148a774650b383a36daded50921858632aa1c"
    sha256 cellar: :any_skip_relocation, ventura:        "ee9bcc9fcac2c928168114ebfa65144fe4ac709e6b83067d472b42046a724899"
    sha256 cellar: :any_skip_relocation, monterey:       "ee9bcc9fcac2c928168114ebfa65144fe4ac709e6b83067d472b42046a724899"
    sha256 cellar: :any_skip_relocation, big_sur:        "ee9bcc9fcac2c928168114ebfa65144fe4ac709e6b83067d472b42046a724899"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ba07785a22eb5cb03d897c63a04173dfff74c6f4def5d13ca855b6f342be441a"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
    generate_completions_from_executable(bin/"whalebrew", "completion")
  end

  test do
    output = shell_output("#{bin}/whalebrew install whalebrew/whalesay -y", 255)
    assert_match(/connect to the Docker daemon|operation not permitted/, output)
  end
end
