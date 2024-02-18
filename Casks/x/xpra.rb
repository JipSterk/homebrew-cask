cask "xpra" do
  arch arm: "arm64", intel: "x86_64"

  on_arm do
    version "5.0.4,1"
    sha256 "8133fedb49f6899fdc7a87cf98021ef08976d1804d74e425a56b1d651ce71710"
  end
  on_intel do
    version "5.0.5,0"
    sha256 "b331c811f585fc878c0397c510b96d22dc2899f9d868d63659952df0975b4a05"
  end

  url "https://www.xpra.org/dists/osx/#{arch}/Xpra-#{arch}-#{version.csv.first}-r#{version.csv.second}.pkg"
  name "Xpra"
  desc "Screen and application forwarding system"
  homepage "https://www.xpra.org/"

  livecheck do
    url "https://www.xpra.org/dists/osx/#{arch}/Xpra-#{arch}.pkg.sha1"
    regex(/#{arch}[._-]v?(\d+(?:\.\d+)+)[._-]r(\d+)\.pkg/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  depends_on macos: ">= :sierra"

  pkg "Xpra-#{arch}-#{version.csv.first}-r#{version.csv.second}.pkg"

  uninstall pkgutil: "org.xpra.pkg",
            delete:  [
              "/Applications/Xpra.app",
              "/usr/local/bin/Xpra*",
            ]

  zap delete: "/Library/Application Support/Xpra",
      trash:  [
        "~/Library/Application Support/Xpra",
        "~/Library/Saved Application State/org.xpra.xpra.savedState",
      ]
end
