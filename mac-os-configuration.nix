{ config, pkgs, ... }:
{
  imports = [
    ./users/andreamaria.piana
  ];

  homebrew = {
    enable = true;
    # onActivation.cleanup = "uninstall";

    taps = [ ];
    brews = [ ];
    casks = [
      "1password-cli"
      "karabiner-elements"
      "kitty"
    ];
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = [
    pkgs.neovim
  ];
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
  security.pam.enableSudoTouchIdAuth = true;
}
