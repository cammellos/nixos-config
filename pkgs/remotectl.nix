{ config, pkgs, user, os, arch, sha256, ... }:

let
  derivation = pkgs.stdenv.mkDerivation rec {
    pname = "remotectl";
    version = "latest";

    src = pkgs.fetchurl {
      url = "https://internal-tools.niceremote.com/remotectl/latest/remotectl-${os}-${arch}";
      sha256 = sha256;
    };

    dontUnpack = true;

    nativeBuildInputs = [ pkgs.autoPatchelfHook ];

    buildInputs = [
      # Add more if needed after checking `ldd`
    ];

    installPhase = ''
      mkdir -p $out/bin
      install -m755 $src $out/bin/remotectl
    '';

    meta = with pkgs.lib; {
      description = "RemoteCTL CLI tool";
      homepage = "https://example.com";
      platforms = platforms.linux;
    };
  };
in
{
  users.users."${user}".packages = [ derivation ];
}
