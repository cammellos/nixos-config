{
  config,
  pkgs,
  unstable,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot.nix
    ./networking/shared.nix
    ./networking/host.nix
    ./pkgs/babashka.nix
    ./pkgs/bluetooth.nix
    ./pkgs/chromium.nix
    ./pkgs/home-manager.nix
    ./pkgs/audio.nix
    ./pkgs/greetd.nix
    ./pkgs/printing.nix
    ./pkgs/console
    ./pkgs/ydotool.nix
    ./pkgs/fonts.nix
    ./pkgs/docker.nix
    ./pkgs/keyball44.nix
    ./pkgs/localization.nix
    ./pkgs/gnupg.nix
    ./users/root
    ./users/cammellos
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.kernelParams = [
    "amd_pstate=active"
    "video=efifb:off"
    "video=simplefb:off"
  ];
  hardware = {
    graphics = {
      enable32Bit = true; # For 32 bit applications
      extraPackages = with pkgs; [
        amdvlk
      ];
      # For 32 bit applications
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    enableAllFirmware = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.udev.packages = with pkgs; [
    pkgs.yubikey-personalization
    uhk-agent
    uhk-udev-rules
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [ uhk-agent ];
  system.stateVersion = "23.11";

  virtualisation.virtualbox = {
    host.enable = true;
    guest = {
      enable = true;
      dragAndDrop = true;
    };

  };
  users.extraGroups.vboxusers.members = [ "cammellos" ];
}
