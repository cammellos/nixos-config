{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.useDHCP = true;
  networking.enableIPv6 = false;

  networking.wireless = {
    enable = true;
  };
}
