{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ chromium ];
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
}
