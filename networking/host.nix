{ config, pkgs, ... }:
{
  networking.hostName = "moosel";
  networking.wireless = {
    interfaces = [ "wlp1s0" ];
  };
}
