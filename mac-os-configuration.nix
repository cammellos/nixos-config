{ config, pkgs, ... }:
{
  imports = [
    ./users/andreamaria.piana

  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages =
    [
      pkgs.neovim
    ];
    system.stateVersion = 5;
    nixpkgs.hostPlatform = "aarch64-darwin";
  }
