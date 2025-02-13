{ config, pkgs, ...}:
let
  derivation = pkgs.stdenv.mkDerivation {
  pname = "remotectl";
  version = "latest";
  src = pkgs.fetchurl {
    url = "https://internal-tools.niceremote.com/remotectl/latest/remotectl-darwin-arm64";
    sha256 = "sha256-M3XMXAs1W4q9UJnZq3bcO6A8mr+P5IbWt94VdtX6htQ=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/remotectl
    chmod +x $out/bin/remotectl
  '';

  meta = {
    description = "RemoteCTL CLI tool";
    homepage = "https://example.com";
    platforms = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];  # Adjust for your OS
  };
  };
in
  {
  users.users."andreamaria.piana".packages = [
    (derivation)
  ];
}
