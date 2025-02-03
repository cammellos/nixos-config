{ config, pkgs, ... }:
{
  hardware.graphics = {
    # this fixes the "glXChooseVisual failed" bug, context: https://github.com/NixOS/nixpkgs/issues/47932
    enable = true;
  };
  users.users.cammellos.packages = with pkgs; [
    quickemu
    lutris
    steam
    wineWowPackages.stable
    wineWowPackages.waylandFull
  ];
}
