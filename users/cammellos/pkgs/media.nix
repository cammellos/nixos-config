{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    librewolf
    spotify
    vlc
  ];

  nixpkgs.config.spotify.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
}
