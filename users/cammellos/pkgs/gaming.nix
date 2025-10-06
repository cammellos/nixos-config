{ config, pkgs, ... }:
{
  hardware.graphics = {
    # this fixes the "glXChooseVisual failed" bug, context: https://github.com/NixOS/nixpkgs/issues/47932
    enable = true;
  };
  programs.steam.enable = true;
  home-manager.users.cammellos.xdg.desktopEntries."mtgo" = {
    name = "mtgo";
    exec = "${config.home-manager.users.cammellos.home.homeDirectory}/.nix-profile/bin/mtgo";
    icon = "windows";
    categories = [ "Game" ];
  };

  home-manager.users.cammellos.home = {

    packages = [
      (pkgs.writeShellScriptBin "mtgo" ''
        quickemu --vm ${config.home-manager.users.cammellos.home.homeDirectory}/documents/quickemu/windows-11.conf --usb-controller xhci
      '')
    ];
  };
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
