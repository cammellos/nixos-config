{ config, pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    enableIPv6 = false;
  };
}
