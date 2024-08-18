{ config, pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot.nix
    ./networking/shared.nix
    ./networking/host.nix
    ./pkgs/home-manager.nix
    ./pkgs/audio.nix
    ./pkgs/greetd.nix
    ./pkgs/printing.nix
    ./pkgs/console
    ./pkgs/fonts.nix
    ./pkgs/docker.nix
    ./pkgs/localization.nix
    ./pkgs/gnupg.nix
    ./users/root
    ./users/cammellos
  ];

  hardware.enableAllFirmware = true;

  services.udev.packages = with pkgs; [
    pkgs.yubikey-personalization
    uhk-agent
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [ uhk-agent ];
  system.stateVersion = "23.11";
}
