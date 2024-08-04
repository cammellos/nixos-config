{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    deluge
    librewolf
    spotify
    vlc
  ];

  nixpkgs.config.spotify.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
}
