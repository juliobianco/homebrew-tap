cask "claudy-usage" do
  version "0.3.1"
  sha256 "80ae33fa67a13f1af7e9fa976cec044746291a38f812f80dcd804ad3b128e30f"

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
