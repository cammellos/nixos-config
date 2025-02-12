{ config, pkgs, ... }:
{
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="5957", ATTRS{idProduct}=="0400", TAG+="uaccess"
  '';
}
