cask "nord-docker-proxy" do
  version "0.2.1"
  sha256 "4dd05e7f29df464510376473cc55d12fbc8c263d86df19af6433002e97dcf967"

  url "https://github.com/taylorbird/nord-docker-proxy/releases/download/v#{version}/nord-docker-proxy-#{version}.zip"
  name "Nord Docker Proxy"
  desc "NordLayer in Docker, exposed to the Mac as a local SOCKS5 proxy"
  homepage "https://github.com/taylorbird/nord-docker-proxy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "Nord Docker Proxy.app"
  binary "#{appdir}/Nord Docker Proxy.app/Contents/Resources/nord-docker-proxy/bin/nord-docker-proxy"

  uninstall quit: "com.tbird.norddockerproxy"

  zap trash: "~/.config/nord-docker-proxy"

  caveats <<~EOS
    Requires Docker Desktop, running. Then:

      nord-docker-proxy setup

    `brew uninstall --zap` removes the config but not the Docker volume holding
    your NordLayer login or the Keychain item holding the proxy password; run
    `nord-docker-proxy logout` first to end the session and delete the login.
  EOS
end
