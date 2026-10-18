cask "claudy-usage" do
  version "0.2.0"
  sha256 "2c279748f19653e620347d3c8f4ded513a167bc5e01751eaec0761a9bb0b7cdc"

  url "https://github.com/juliobianco/claudy-usage-mac/releases/download/v#{version}/ClaudyUsage-#{version}-macos.zip"
  name "Claudy Usage"
  desc "Menu bar widget for Claude Code limits and sessions"
  homepage "https://github.com/juliobianco/claudy-usage-mac"

  depends_on macos: :sonoma

  app "ClaudyUsage.app"

  # Ad-hoc signed, not notarized (no Apple Developer ID): drop the quarantine flag so it opens without "Open Anyway".
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/ClaudyUsage.app"]
  end

  zap trash: [
    "~/Library/Application Support/ClaudyUsage",
    "~/Library/Logs/ClaudyUsage.log",
    "~/Library/Preferences/dev.julio.claudy-usage.plist",
  ]
end
