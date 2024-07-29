{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    chromium
    spotify
    vlc
  ];

  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
}
