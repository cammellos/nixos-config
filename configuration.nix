{ config, pkgs, ...}:
{
  imports =
    [ # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ./boot.nix
    ./networking/shared.nix
    ./networking/host.nix
    ./pkgs/home-manager.nix
    ./pkgs/audio.nix
    ./pkgs/x.nix
    ./pkgs/printing.nix
    ./pkgs/console.nix
    ./pkgs/fonts.nix
    ./pkgs/docker.nix
    ./pkgs/localization.nix
    ./pkgs/gnupg.nix
    ./users/root
    ./users/cammellos
  ];

  hardware.enableAllFirmware = true;

  services.udev.packages = with pkgs; [ pkgs.yubikey-personalization uhk-agent ];

  # programs
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    uhk-agent
  ];
  system.stateVersion = "23.11";
}
