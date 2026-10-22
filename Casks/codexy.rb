cask "codexy" do
  version "0.1.0"
  sha256 "7bfeeb0a8aed6aea769b2adcdf8ca43c08ac0aaed914704552b112e832392927"

  url "https://github.com/juliobianco/codexy/releases/download/v#{version}/Codexy-#{version}-macos.zip"
  name "Codexy"
  desc "Menu bar widget for OpenAI Codex plan limits and sessions"
  homepage "https://github.com/juliobianco/codexy"

  depends_on macos: :sonoma

  app "Codexy.app"

  # Ad-hoc signed, not notarized (no Apple Developer ID): drop the quarantine flag so it opens without "Open Anyway".
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/Codexy.app"], must_succeed: false
    run "/usr/bin/open", args: ["/Applications/Codexy.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/Codexy",
    "~/Library/Logs/Codexy.log",
    "~/Library/Preferences/dev.julio.codexy.plist",
  ]
end
