{ config, pkgs, ... }:
{
  users.users.cammellos = {
    packages = with pkgs; [
      networkmanagerapplet
      openvpn
    ];
  };
}
