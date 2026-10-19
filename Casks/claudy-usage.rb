cask "claudy-usage" do
  version "0.5.0"
  sha256 "f0c175fe1d670375ad87e5413d76e52db9ef763c89285f21bbc1fad14ae8b115"

  url "https://github.com/juliobianco/claudy-usage-mac/releases/download/v#{version}/ClaudyUsage-#{version}-macos.zip"
  name "Claudy Usage"
  desc "Menu bar widget for Claude Code limits and sessions"
  homepage "https://github.com/juliobianco/claudy-usage-mac"

  depends_on macos: :sonoma

  app "ClaudyUsage.app"

  # Ad-hoc signed, not notarized (no Apple Developer ID): drop the quarantine flag so it opens without "Open Anyway".
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/ClaudyUsage.app"], must_succeed: false
    # Start it right after install; the menu bar icon appears without a manual launch.
    run "/usr/bin/open", args: ["/Applications/ClaudyUsage.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/ClaudyUsage",
    "~/Library/Logs/ClaudyUsage.log",
    "~/Library/Preferences/dev.julio.claudy-usage.plist",
  ]
end
