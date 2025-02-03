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
    system.configurationRevision =  self.rev or self.dirtyRev or null;
    system.stateVersion = 6;
    nixpkgs.hostPlatform = "aarch64-darwin";
  };
