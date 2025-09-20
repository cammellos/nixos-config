{ config, pkgs, ... }:
{
  hardware.graphics = {
    # this fixes the "glXChooseVisual failed" bug, context: https://github.com/NixOS/nixpkgs/issues/47932
    enable = true;
  };
  programs.steam.enable = true;
  users.users.cammellos.packages = with pkgs; [
    quickemu
    lutris
    steam
    steam-devices-udev-rules
    wineWowPackages.stable
    wineWowPackages.waylandFull
    (retroarch.withCores (
      cores: with cores; [
        snes9x
        mgba
      ]
    ))

  ];
}
