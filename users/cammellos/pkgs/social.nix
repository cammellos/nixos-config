{ config, pkgs, ... }:
let
  ferdium = pkgs.symlinkJoin {
    name = "ferdium";
    paths = [
      (pkgs.callPackage ./ferdium.nix {
        mkFranzDerivation =
          pkgs.callPackage "${pkgs.path}/pkgs/applications/networking/instant-messengers/franz/generic.nix"
            { };
      })
    ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/ferdium \
        --append-flags --enable-features=WebRTCPipeWireCapturer \
        --append-flags --enable-features=UseOzonePlatform \
        --append-flags --ozone-platform-hint=auto
    '';
  };
in
{
  users.users.cammellos.packages = with pkgs; [
    ferdium
  ];
}
