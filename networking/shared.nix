{ config, pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    useDHCP = true;
    enableIPv6 = false;

    wireless = {
      enable = true;
    };
  };
}
