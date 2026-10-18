cask "claudy-usage" do
  version "0.3.0"
  sha256 "18aaf9cd07fae81c83d33ef726db31baac40da96d2ba3b9441c3eb3beecd906a"

  url "https://github.com/juliobianco/claudy-usage-mac/releases/download/v#{version}/ClaudyUsage-#{version}-macos.zip"
  name "Claudy Usage"
  desc "Menu bar widget for Claude Code limits and sessions"
  homepage "https://github.com/juliobianco/claudy-usage-mac"

  depends_on macos: :sonoma

  app "ClaudyUsage.app"

  # Ad-hoc signed, not notarized (no Apple Developer ID): drop the quarantine flag so it opens without "Open Anyway".
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/ClaudyUsage.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/ClaudyUsage",
    "~/Library/Logs/ClaudyUsage.log",
    "~/Library/Preferences/dev.julio.claudy-usage.plist",
  ]
end
