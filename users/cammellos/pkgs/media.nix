{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    chromium
    spotify
    vlc
  ];

  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  nixpkgs.config.spotify.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
}
